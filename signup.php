<?php
require 'config.php';
require 'auth.php';

$message = '';
$username = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $username = trim($_POST['username'] ?? '');
  $password = $_POST['password'] ?? '';
  $confirm  = $_POST['confirm_password'] ?? '';

  if (
    $username === '' ||
    $password === '' ||
    $confirm === ''
) {
    $message = "Please complete all fields.";

} elseif (strlen($username) < 3) {
    $message =
        "Username must contain at least 3 characters.";

} elseif (strlen($password) < 8) {
    $message =
        "Password must contain at least 8 characters.";

} elseif (!preg_match('/[A-Za-z]/', $password)) {
    $message =
        "Password must contain at least one letter.";

} elseif (!preg_match('/[0-9]/', $password)) {
    $message =
        "Password must contain at least one number.";

} elseif ($password !== $confirm) {
    $message = "Passwords do not match.";

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
  <link rel="stylesheet" href="styles.css?v=4" />
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
    <h1>Create account</h1>

<p class="auth-subtitle">
  Join Wasfatna to save favorite recipes and personal preferences.
</p>

<?php if ($message): ?>
  <div class="msg" role="alert">
    ❌ <?= htmlspecialchars($message) ?>
  </div>
<?php endif; ?>

<form method="POST" id="signupForm">

  <label for="signupUsername">
    Username
  </label>

  <input
    id="signupUsername"
    type="text"
    name="username"
    placeholder="Enter your username"
    value="<?= htmlspecialchars($username) ?>"
    autocomplete="username"
    minlength="3"
    required
  >

  <label for="signupPassword">
    Password
  </label>

  <div class="password-wrapper">

    <input
      id="signupPassword"
      type="password"
      name="password"
      placeholder="Create a password"
      autocomplete="new-password"
      minlength="8"
      required
    >

    <button
      type="button"
      id="toggleSignupPassword"
      class="password-toggle"
      aria-label="Show password"
      title="Show password"
    >
      👁
    </button>

  </div>

  <div class="password-strength">

    <div class="password-strength-track">
      <div
        id="passwordStrengthBar"
        class="password-strength-bar"
      ></div>
    </div>

    <span id="passwordStrengthText">
      Password strength
    </span>

  </div>

  <p class="password-requirements">
    Use at least 8 characters, including a letter and a number.
  </p>

  <label for="confirmPassword">
    Confirm password
  </label>

  <div class="password-wrapper">

    <input
      id="confirmPassword"
      type="password"
      name="confirm_password"
      placeholder="Enter the password again"
      autocomplete="new-password"
      minlength="8"
      required
    >

    <button
      type="button"
      id="toggleConfirmPassword"
      class="password-toggle"
      aria-label="Show confirmation password"
      title="Show password"
    >
      👁
    </button>

  </div>

  <div
    id="passwordMatchMessage"
    class="password-match-message"
    aria-live="polite"
  ></div>

  <div class="row">

    <button
      class="btn btn-primary"
      type="submit"
      id="signupBtn"
    >
      <span class="signup-btn-text">
        Sign Up
      </span>

      <span
        class="signup-spinner"
        hidden
      ></span>
    </button>

    <a
      class="btn btn-outline"
      href="signin.php"
    >
      Sign In
    </a>

  </div>

</form>
  </div>
</body>
</html>
