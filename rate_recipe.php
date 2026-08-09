<?php

require 'config.php';
require 'auth.php';

header('Content-Type: application/json');

if (!is_logged_in() || empty($_SESSION['user_id'])) {
    echo json_encode([
        'success' => false,
        'message' => 'Please sign in to rate recipes.'
    ]);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);

$recipeId = isset($input['recipe_id'])
    ? (int)$input['recipe_id']
    : 0;

$rating = isset($input['rating'])
    ? (int)$input['rating']
    : 0;

if ($recipeId <= 0 || $rating < 1 || $rating > 5) {
    echo json_encode([
        'success' => false,
        'message' => 'Invalid recipe or rating.'
    ]);
    exit;
}

$userId = (int)$_SESSION['user_id'];

try {

    $stmt = $pdo->prepare("
        INSERT INTO recipe_ratings (
            user_id,
            recipe_id,
            rating
        )
        VALUES (
            :user_id,
            :recipe_id,
            :rating
        )

        ON DUPLICATE KEY UPDATE
            rating = VALUES(rating),
            updated_at = CURRENT_TIMESTAMP
    ");

    $stmt->execute([
        ':user_id' => $userId,
        ':recipe_id' => $recipeId,
        ':rating' => $rating
    ]);

    $avgStmt = $pdo->prepare("
        SELECT
            ROUND(AVG(rating), 1) AS average_rating,
            COUNT(*) AS rating_count
        FROM recipe_ratings
        WHERE recipe_id = :recipe_id
    ");

    $avgStmt->execute([
        ':recipe_id' => $recipeId
    ]);

    $summary = $avgStmt->fetch();

    echo json_encode([
        'success' => true,
        'message' => 'Rating saved.',
        'average_rating' => $summary['average_rating'] ?? 0,
        'rating_count' => $summary['rating_count'] ?? 0,
        'user_rating' => $rating
    ]);

} catch (Throwable $error) {

    echo json_encode([
        'success' => false,
        'message' => 'Unable to save rating.'
    ]);
}
