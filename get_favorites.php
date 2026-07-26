<?php
session_start();

header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . '/config.php';

function respond(array $payload, int $status = 200): void
{
    http_response_code($status);

    echo json_encode(
        $payload,
        JSON_UNESCAPED_UNICODE |
        JSON_UNESCAPED_SLASHES
    );

    exit;
}

if (!isset($_SESSION['user_id'])) {
    respond([
        'success' => false,
        'message' => 'You must be signed in to view favorites.'
    ], 401);
}

$userId = (int)$_SESSION['user_id'];

try {
    $stmt = $pdo->prepare("
        SELECT
            r.recipe_id,
            r.recipe_name,
            r.image,
            r.description,
            r.prep_time,
            r.cook_time,
            r.servings,
            r.difficulty,
            r.spice_level,
            r.diet,
            r.goal

        FROM favorites f

        JOIN recipes r
            ON r.recipe_id = f.recipe_id

        WHERE f.user_id = :user_id

        ORDER BY
            f.created_at DESC,
            r.recipe_name ASC
    ");

    $stmt->execute([
        ':user_id' => $userId
    ]);

    $recipes = $stmt->fetchAll();

    if (!$recipes) {
        respond([
            'success' => true,
            'recipes' => []
        ]);
    }

    $recipeIds = array_map(
        'intval',
        array_column($recipes, 'recipe_id')
    );

    $idMarks = implode(
        ',',
        array_fill(0, count($recipeIds), '?')
    );

    /*
     * Load ingredients.
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
     * Load preparation steps.
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

    foreach ($recipes as &$recipe) {
        $recipeId = (int)$recipe['recipe_id'];

        $recipe['recipe_id'] = $recipeId;
        $recipe['image'] = $recipe['image'] ?? '';
        $recipe['ingredients'] =
            $ingredientsByRecipe[$recipeId] ?? [];
        $recipe['steps'] =
            $stepsByRecipe[$recipeId] ?? [];
        $recipe['is_favorite'] = true;
    }

    unset($recipe);

    respond([
        'success' => true,
        'recipes' => $recipes
    ]);

} catch (Throwable $e) {
    respond([
        'success' => false,
        'message' =>
            'Unable to load favorites: ' .
            $e->getMessage()
    ], 500);
}
