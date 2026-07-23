<?php
header('Content-Type: application/json; charset=utf-8');
require_once __DIR__ . '/config.php';

function respond(array $payload, int $status = 200): void {
    http_response_code($status);
    echo json_encode($payload, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respond(['success' => false, 'message' => 'Only POST requests are allowed.'], 405);
}

try {
    $input = json_decode(file_get_contents('php://input'), true, 512, JSON_THROW_ON_ERROR);
    $entered = $input['ingredients'] ?? [];

    if (!is_array($entered)) {
        respond(['success' => false, 'message' => 'Ingredients must be sent as a list.'], 400);
    }

    $entered = array_values(array_unique(array_filter(array_map(
        static fn($value) => mb_strtolower(trim((string)$value)),
        $entered
    ))));

    if (!$entered) {
        respond(['success' => true, 'recipes' => []]);
    }

    // Load recipes with at least one exact ingredient-name match.
    $matchParts = [];
    $params = [];
    foreach ($entered as $index => $ingredient) {
        $key = ':ingredient_' . $index;
        $matchParts[] = "LOWER(TRIM(i.ingredient_name)) = $key";
        $params[$key] = $ingredient;
    }
    $matchCondition = implode(' OR ', $matchParts);

    $sql = "
        SELECT
            r.recipe_id,
            r.recipe_name,
            COUNT(DISTINCT CASE WHEN ($matchCondition) THEN i.ingredient_id END) AS matched_count,
            COUNT(DISTINCT i.ingredient_id) AS total_ingredients
        FROM recipes r
        JOIN recipe_ingredients ri ON ri.recipe_id = r.recipe_id
        JOIN ingredients i ON i.ingredient_id = ri.ingredient_id
        GROUP BY r.recipe_id, r.recipe_name
        HAVING matched_count > 0
        ORDER BY matched_count DESC, total_ingredients ASC, r.recipe_name ASC
    ";

    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    $recipes = $stmt->fetchAll();

    if (!$recipes) {
        respond(['success' => true, 'recipes' => []]);
    }

    $recipeIds = array_map('intval', array_column($recipes, 'recipe_id'));
    $idMarks = implode(',', array_fill(0, count($recipeIds), '?'));

    $ingredientStmt = $pdo->prepare("
        SELECT ri.recipe_id, i.ingredient_name, ri.quantity
        FROM recipe_ingredients ri
        JOIN ingredients i ON i.ingredient_id = ri.ingredient_id
        WHERE ri.recipe_id IN ($idMarks)
        ORDER BY ri.recipe_id, ri.id
    ");
    $ingredientStmt->execute($recipeIds);

    $ingredientsByRecipe = [];
    foreach ($ingredientStmt->fetchAll() as $row) {
        $ingredientsByRecipe[(int)$row['recipe_id']][] = [
            'name' => $row['ingredient_name'],
            'quantity' => $row['quantity']
        ];
    }

    $stepsStmt = $pdo->prepare("
        SELECT recipe_id, step_number, instruction
        FROM recipe_steps
        WHERE recipe_id IN ($idMarks)
        ORDER BY recipe_id, step_number
    ");
    $stepsStmt->execute($recipeIds);

    $stepsByRecipe = [];
    foreach ($stepsStmt->fetchAll() as $row) {
        $stepsByRecipe[(int)$row['recipe_id']][] = $row['instruction'];
    }

    $enteredSet = array_fill_keys($entered, true);
    foreach ($recipes as &$recipe) {
        $id = (int)$recipe['recipe_id'];
        $all = $ingredientsByRecipe[$id] ?? [];
        $matched = [];
        $missing = [];

        foreach ($all as $ingredient) {
            $normalized = mb_strtolower(trim($ingredient['name']));
            if (isset($enteredSet[$normalized])) {
                $matched[] = $ingredient;
            } else {
                $missing[] = $ingredient;
            }
        }

        $recipe['recipe_id'] = $id;
        $recipe['matched_count'] = count($matched);
        $recipe['total_ingredients'] = count($all);
        $recipe['match_percentage'] = count($all) > 0
            ? (int)round((count($matched) / count($all)) * 100)
            : 0;
        $recipe['matched_ingredients'] = $matched;
        $recipe['missing_ingredients'] = $missing;
        $recipe['steps'] = $stepsByRecipe[$id] ?? [];
    }
    unset($recipe);

    respond(['success' => true, 'recipes' => $recipes]);
} catch (JsonException $e) {
    respond(['success' => false, 'message' => 'Invalid JSON request.'], 400);
} catch (Throwable $e) {
    respond(['success' => false, 'message' => 'Database recipe search failed: ' . $e->getMessage()], 500);
}
