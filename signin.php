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
  <link rel="stylesheet" href="styles.css?v=11" />
  <script>var t=localStorage.getItem("wasfatna-theme");if(t)document.documentElement.setAttribute("data-theme",t);</script>
  <style>
    body{display:flex;min-height:100vh;align-items:center;justify-content:center;background:var(--bg);color:var(--text);}
    .auth{width:min(420px,92vw);background:var(--card);border:1px solid var(--line);
      padding:18px;border-radius:18px}
    .auth h1{margin:0 0 12px}
    .auth input{width:100%;padding:12px;border-radius:14px;border:1px solid var(--line);
      background:rgba(11,18,32,.55);color:var(--text);margin:8px 0;outline:none}
    .auth .row{display:flex;gap:10px;margin-top:10px}
    .msg{color:#ff8a8a;margin:8px 0}
    .auth-close{position:absolute;top:10px;right:10px;background:transparent;border:none;color:var(--muted);font-size:18px;cursor:pointer;line-height:1;padding:4px 8px;border-radius:8px;}
    .auth-close:hover{background:rgba(255,255,255,.08);color:var(--text)}
    .auth{position:relative}
    [data-theme="light"] .auth input{background:#f9f9f9;border-color:rgba(0,0,0,.15)}
    [data-theme="light"] .auth-close:hover{background:rgba(0,0,0,.08)}
  </style>
</head>
<body>
  <div class="auth">
    <a href="index.php" class="auth-close" title="Back to home">✕</a>
    <h1>Welcome back</h1>
    <?php if ($message): ?><div class="msg"><?= htmlspecialchars($message) ?></div><?php endif; ?>

    <form method="POST">
      <input name="username" placeholder="Username" required />
      <div class="password-wrapper">

  <input
    id="passwordInput"
    type="password"
    name="password"
    placeholder="Password"
    required
  />

  <button
    type="button"
    id="togglePassword"
    class="password-toggle"
    aria-label="Show password"
  >
    👁
  </button>

</div>
      <div class="row">
        <button class="btn btn-primary" type="submit">Sign In</button>
        <a class="btn btn-outline" href="signup.php">Sign Up</a>
      </div>
    </form>
  </div>
</body>
</html>
