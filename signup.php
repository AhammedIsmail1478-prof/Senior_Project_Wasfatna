<?php
require 'config.php';
require 'auth.php';

$message = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $username = trim($_POST['username'] ?? '');
  $password = $_POST['password'] ?? '';
  $confirm  = $_POST['confirm_password'] ?? '';

  if ($username === '' || $password === '') {
    $message = "Please fill all fields.";
  } elseif ($password !== $confirm) {
    $message = "Passwords do not match!";
  } else {
    // Check if username exists
    $stmt = $pdo->prepare("SELECT id FROM users WHERE username = :username");
    $stmt->execute(['username' => $username]);
    if ($stmt->fetch()) {
      $message = "Username already taken.";
    } else {
      $hash = password_hash($password, PASSWORD_DEFAULT);

      $pdo->beginTransaction();
      try {
        $stmt = $pdo->prepare("INSERT INTO users (username, password_hash) VALUES (:username, :hash)");
        $stmt->execute(['username' => $username, 'hash' => $hash]);

        $user_id = (int)$pdo->lastInsertId();

        // Create default preferences row
        $stmt = $pdo->prepare("INSERT INTO user_preferences (user_id) VALUES (:user_id)");
        $stmt->execute(['user_id' => $user_id]);

        $pdo->commit();

        // Auto-login and go to profile to fill preferences
        $_SESSION['user_id'] = $user_id;
        $_SESSION['username'] = $username;
        header("Location: profile.php");
        exit;
      } catch (Exception $e) {
        $pdo->rollBack();
        $message = "Error creating account. Try again.";
      }
    }
  }
}
?>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Sign Up</title>
  <link rel="stylesheet" href="styles.css" />
  <style>
    body{display:flex;min-height:100vh;align-items:center;justify-content:center;}
    .auth{width:min(420px,92vw);background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.10);
      padding:18px;border-radius:18px}
    .auth h1{margin:0 0 12px}
    .auth input{width:100%;padding:12px;border-radius:14px;border:1px solid rgba(255,255,255,.10);
      background:rgba(11,18,32,.55);color:#e9eef7;margin:8px 0;outline:none}
    .auth .row{display:flex;gap:10px;margin-top:10px}
    .msg{color:#ff8a8a;margin:8px 0}
  </style>
</head>
<body>
  <div class="auth">
    <h1>Create account</h1>
    <?php if ($message): ?><div class="msg"><?= htmlspecialchars($message) ?></div><?php endif; ?>

    <form method="POST">
      <input name="username" placeholder="Username" required />
      <input type="password" name="password" placeholder="Password" required />
      <input type="password" name="confirm_password" placeholder="Confirm password" required />
      <div class="row">
        <button class="btn btn-primary" type="submit">Sign Up</button>
        <a class="btn btn-outline" href="signin.php">Sign In</a>
      </div>
    </form>
  </div>
</body>
</html>