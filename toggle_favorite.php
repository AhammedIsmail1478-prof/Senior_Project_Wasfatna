<?php
session_start();

header('Content-Type: application/json');

require_once 'config.php';

if (!isset($_SESSION['user_id'])) {
    echo json_encode([
        'success' => false,
        'message' => 'You must be logged in.'
    ]);
    exit;
}

$data = json_decode(file_get_contents('php://input'), true);

$recipeId = isset($data['recipe_id'])
    ? (int) $data['recipe_id']
    : 0;

$userId = (int) $_SESSION['user_id'];

if ($recipeId <= 0) {
    echo json_encode([
        'success' => false,
        'message' => 'Invalid recipe ID.'
    ]);
    exit;
}

try {
    // Check whether this recipe is already saved.
    $checkStmt = $pdo->prepare(
        'SELECT favorite_id
         FROM favorites
         WHERE user_id = ? AND recipe_id = ?'
    );

    $checkStmt->execute([$userId, $recipeId]);

    $favorite = $checkStmt->fetch();

    if ($favorite) {
        // Already saved, so remove it.
        $deleteStmt = $pdo->prepare(
            'DELETE FROM favorites
             WHERE user_id = ? AND recipe_id = ?'
        );

        $deleteStmt->execute([$userId, $recipeId]);

        echo json_encode([
            'success' => true,
            'is_favorite' => false,
            'message' => 'Recipe removed from favorites.'
        ]);
    } else {
        // Not saved yet, so add it.
        $insertStmt = $pdo->prepare(
            'INSERT INTO favorites (user_id, recipe_id)
             VALUES (?, ?)'
        );

        $insertStmt->execute([$userId, $recipeId]);

        echo json_encode([
            'success' => true,
            'is_favorite' => true,
            'message' => 'Recipe added to favorites.'
        ]);
    }
} catch (PDOException $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Unable to update favorites.'
    ]);
}
