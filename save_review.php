<?php

require 'config.php';
require 'auth.php';

header('Content-Type: application/json');

if (!is_logged_in() || empty($_SESSION['user_id'])) {
    echo json_encode([
        'success' => false,
        'message' => 'Please sign in to write a review.'
    ]);
    exit;
}

$input = json_decode(
    file_get_contents('php://input'),
    true
);

$recipeId = isset($input['recipe_id'])
    ? (int)$input['recipe_id']
    : 0;

$reviewText = trim(
    $input['review_text'] ?? ''
);

if ($recipeId <= 0) {
    echo json_encode([
        'success' => false,
        'message' => 'Invalid recipe.'
    ]);
    exit;
}

if ($reviewText === '') {
    echo json_encode([
        'success' => false,
        'message' => 'Please write a review.'
    ]);
    exit;
}

if (mb_strlen($reviewText) > 500) {
    echo json_encode([
        'success' => false,
        'message' => 'Review must be 500 characters or less.'
    ]);
    exit;
}

$userId = (int)$_SESSION['user_id'];

try {

    $stmt = $pdo->prepare("
        INSERT INTO recipe_reviews (
            user_id,
            recipe_id,
            review_text
        )
        VALUES (
            :user_id,
            :recipe_id,
            :review_text
        )
    ");

    $stmt->execute([
        ':user_id' => $userId,
        ':recipe_id' => $recipeId,
        ':review_text' => $reviewText
    ]);

    echo json_encode([
        'success' => true,
        'message' => 'Review posted successfully.',
        'review_id' => (int)$pdo->lastInsertId(),
        'username' => $_SESSION['username'] ?? 'User',
        'review_text' => $reviewText
    ]);

} catch (Throwable $error) {

    echo json_encode([
        'success' => false,
        'message' => 'Unable to save review.'
    ]);
}
