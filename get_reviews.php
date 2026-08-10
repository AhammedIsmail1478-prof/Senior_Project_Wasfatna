<?php

require 'config.php';

header('Content-Type: application/json');

$recipeId = isset($_GET['recipe_id'])
    ? (int)$_GET['recipe_id']
    : 0;

if ($recipeId <= 0) {
    echo json_encode([
        'success' => false,
        'message' => 'Invalid recipe.',
        'reviews' => []
    ]);
    exit;
}

try {

    $stmt = $pdo->prepare("
        SELECT
            rr.review_id,
            rr.review_text,
            rr.created_at,
            u.username
        FROM recipe_reviews rr

        INNER JOIN users u
            ON u.id = rr.user_id

        WHERE rr.recipe_id = :recipe_id

        ORDER BY rr.created_at DESC
    ");

    $stmt->execute([
        ':recipe_id' => $recipeId
    ]);

    $reviews = $stmt->fetchAll();

    echo json_encode([
        'success' => true,
        'reviews' => $reviews,
        'review_count' => count($reviews)
    ]);

} catch (Throwable $error) {

    echo json_encode([
        'success' => false,
        'message' => 'Unable to load reviews.',
        'reviews' => []
    ]);
}
