<?php
require 'config.php';
require 'auth.php';

$message = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $username = trim($_POST['username'] ?? '');
  $password = $_POST['password'] ?? '';

  $stmt = $pdo->prepare("SELECT id, username, password_hash FROM users WHERE username = :username");
  $stmt->execute(['username' => $username]);
  $user = $stmt->fetch();

  if ($user && password_verify($password, $user['password_hash'])) {
    $_SESSION['user_id'] = (int)$user['id'];
    $_SESSION['username'] = $user['username'];
    header("Location: index.php");
    exit;
  } else {
    $message = "Invalid username or password.";
  }
}
?>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Sign In</title>
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
    <h1>Welcome back</h1>
    <?php if ($message): ?><div class="msg"><?= htmlspecialchars($message) ?></div><?php endif; ?>

    <form method="POST">
      <input name="username" placeholder="Username" required />
      <input type="password" name="password" placeholder="Password" required />
      <div class="row">
        <button class="btn btn-primary" type="submit">Sign In</button>
        <a class="btn btn-outline" href="signup.php">Sign Up</a>
      </div>
    </form>
  </div>
</body>
</html>