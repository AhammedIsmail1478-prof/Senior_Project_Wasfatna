<?php
session_start();

header('Content-Type: application/json; charset=utf-8');
require_once __DIR__ . '/config.php';

function respond(array $payload, int $status = 200): void
{
    http_response_code($status);

    echo json_encode(
        $payload,
        JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES
    );

    exit;
} 

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respond([
        'success' => false,
        'message' => 'Only POST requests are allowed.'
    ], 405);
}

try {
    $input = json_decode(
        file_get_contents('php://input'),
        true,
        512,
        JSON_THROW_ON_ERROR
    );

    $entered = $input['ingredients'] ?? [];

    $spice = mb_strtolower(
        trim((string)($input['spice'] ?? 'any'))
    );

    $goal = mb_strtolower(
        trim((string)($input['goal'] ?? 'any'))
    );

    $diet = mb_strtolower(
        trim((string)($input['diet'] ?? 'none'))
    );

    if (!is_array($entered)) {
        respond([
            'success' => false,
            'message' => 'Ingredients must be sent as a list.'
        ], 400);
    }

    // Clean and normalize the entered ingredients.
    $entered = array_values(
        array_unique(
            array_filter(
                array_map(
                    static fn($value) =>
                        mb_strtolower(trim((string)$value)),
                    $entered
                )
            )
        )
    );

    if (!$entered) {
        respond([
            'success' => true,
            'recipes' => []
        ]);
    }

    /*
     * Build the ingredient-matching conditions.
     */
    $matchParts = [];
    $params = [];

    foreach ($entered as $index => $ingredient) {
        $key = ':ingredient_' . $index;

        $matchParts[] =
            "LOWER(TRIM(i.ingredient_name)) = $key";

        $params[$key] = $ingredient;
    }

    $matchCondition = implode(' OR ', $matchParts);

    /*
     * Build preference filters.
     *
     * "any" means no spice or goal restriction.
     * "none" means no dietary restriction.
     */
    $whereConditions = [];

    if ($spice !== '' && $spice !== 'any') {
        $whereConditions[] =
            "LOWER(TRIM(r.spice_level)) = :spice";

        $params[':spice'] = $spice;
    }

    if ($diet !== '' && $diet !== 'none' && $diet !== 'any') {
    $whereConditions[] =
        "FIND_IN_SET(
            :diet,
            REPLACE(LOWER(r.diet), ' ', '')
        ) > 0";

    $params[':diet'] = str_replace(' ', '', $diet);
}

    if ($goal !== '' && $goal !== 'any' && $goal !== 'none') {
        $whereConditions[] =
            "LOWER(TRIM(r.goal)) = :goal";

        $params[':goal'] = $goal;
    }

    $whereSql = '';

    if ($whereConditions) {
        $whereSql = 'WHERE ' . implode(' AND ', $whereConditions);
    }

    /*
     * Search for recipes that:
     * 1. Match the selected preferences.
     * 2. Contain at least one entered ingredient.
     */
    $sql = "
        SELECT
        r.recipe_id,
        r.recipe_name,
        r.image,
        r.spice_level,
        r.diet,
        r.goal,
        r.servings,
        r.difficulty,

            COUNT(
                DISTINCT CASE
                    WHEN ($matchCondition)
                    THEN i.ingredient_id
                END
            ) AS matched_count,

            COUNT(DISTINCT i.ingredient_id) AS total_ingredients

        FROM recipes r

        JOIN recipe_ingredients ri
            ON ri.recipe_id = r.recipe_id

        JOIN ingredients i
            ON i.ingredient_id = ri.ingredient_id

        $whereSql

        GROUP BY
        r.recipe_id,
        r.recipe_name,
        r.image,
        r.spice_level,
        r.diet,
        r.goal,
        r.servings,
        r.difficulty

        HAVING matched_count > 0

        ORDER BY
            matched_count DESC,
            total_ingredients ASC,
            r.recipe_name ASC
    ";

    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);

    $recipes = $stmt->fetchAll();

    if (!$recipes) {
        respond([
            'success' => true,
            'recipes' => []
        ]);
    }

    /*
     * Get the IDs of all matching recipes.
     */
    $recipeIds = array_map(
        'intval',
        array_column($recipes, 'recipe_id')
    );

    $idMarks = implode(
        ',',
        array_fill(0, count($recipeIds), '?')
    );
    /*
 * Load the logged-in user's favorite recipes.
 */
$userId = isset($_SESSION['user_id'])
    ? (int)$_SESSION['user_id']
    : 0;

$favoriteSet = [];

if ($userId > 0) {
    $favoriteStmt = $pdo->prepare("
        SELECT recipe_id
        FROM favorites
        WHERE user_id = ?
        AND recipe_id IN ($idMarks)
    ");

    $favoriteParams = array_merge(
        [$userId],
        $recipeIds
    );

    $favoriteStmt->execute($favoriteParams);

    $favoriteRecipeIds = array_map(
        'intval',
        $favoriteStmt->fetchAll(
            PDO::FETCH_COLUMN
        )
    );

    $favoriteSet = array_fill_keys(
        $favoriteRecipeIds,
        true
    );
}

    /*
     * Load all ingredients for the matching recipes.
     */
    $ingredientStmt = $pdo->prepare("
        SELECT
            ri.recipe_id,
            i.ingredient_name,
            ri.quantity

        FROM recipe_ingredients ri

        JOIN ingredients i
            ON i.ingredient_id = ri.ingredient_id

        WHERE ri.recipe_id IN ($idMarks)

        ORDER BY
            ri.recipe_id,
            ri.id
    ");

    $ingredientStmt->execute($recipeIds);

    $ingredientsByRecipe = [];

    foreach ($ingredientStmt->fetchAll() as $row) {
        $recipeId = (int)$row['recipe_id'];

        $ingredientsByRecipe[$recipeId][] = [
            'name' => $row['ingredient_name'],
            'quantity' => $row['quantity']
        ];
    }

    /*
     * Load all preparation steps.
     */
    $stepsStmt = $pdo->prepare("
        SELECT
            recipe_id,
            step_number,
            instruction

        FROM recipe_steps

        WHERE recipe_id IN ($idMarks)

        ORDER BY
            recipe_id,
            step_number
    ");

    $stepsStmt->execute($recipeIds);

    $stepsByRecipe = [];

    foreach ($stepsStmt->fetchAll() as $row) {
        $recipeId = (int)$row['recipe_id'];

        $stepsByRecipe[$recipeId][] =
            $row['instruction'];
    }

    /*
     * Calculate matched ingredients,
     * missing ingredients and match percentage.
     */
    $enteredSet = array_fill_keys($entered, true);

    foreach ($recipes as &$recipe) {
        $id = (int)$recipe['recipe_id'];

     $recipe['is_favorite'] =
            isset($favoriteSet[$id]);
        

        $recipe['image'] =
        $recipe['image'] ?? '';

        $allIngredients =
            $ingredientsByRecipe[$id] ?? [];

        $matchedIngredients = [];
        $missingIngredients = [];

        foreach ($allIngredients as $ingredient) {
            $normalizedName = mb_strtolower(
                trim($ingredient['name'])
            );

            if (isset($enteredSet[$normalizedName])) {
                $matchedIngredients[] = $ingredient;
            } else {
                $missingIngredients[] = $ingredient;
            }
        }

        $totalIngredients = count($allIngredients);
        $matchedCount = count($matchedIngredients);

        $recipe['recipe_id'] = $id;
        $recipe['matched_count'] = $matchedCount;
        $recipe['total_ingredients'] = $totalIngredients;

        $recipe['match_percentage'] =
            $totalIngredients > 0
                ? (int)round(
                    ($matchedCount / $totalIngredients) * 100
                )
                : 0;

        $recipe['matched_ingredients'] =
            $matchedIngredients;

        $recipe['missing_ingredients'] =
            $missingIngredients;

        $recipe['steps'] =
            $stepsByRecipe[$id] ?? [];
    }

    unset($recipe);
usort($recipes, function ($a, $b) {
    if ($a['match_percentage'] !== $b['match_percentage']) {
        return $b['match_percentage'] <=> $a['match_percentage'];
    }

    if ($a['matched_count'] !== $b['matched_count']) {
        return $b['matched_count'] <=> $a['matched_count'];
    }

    return $a['total_ingredients'] <=> $b['total_ingredients'];
});
    
    respond([
        'success' => true,
        'recipes' => $recipes
    ]);

} catch (JsonException $e) {
    respond([
        'success' => false,
        'message' => 'Invalid JSON request.'
    ], 400);

} catch (Throwable $e) {
    respond([
        'success' => false,
        'message' =>
            'Database recipe search failed: ' .
            $e->getMessage()
    ], 500);
}
