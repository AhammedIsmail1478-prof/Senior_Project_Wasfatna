<?php
require 'config.php';
require 'auth.php';
require_login();

$user_id = (int)$_SESSION['user_id'];
$message = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $spice = $_POST['spice_level'] ?? 'medium';
  $diet  = $_POST['diet'] ?? 'none';
  $likes = trim($_POST['likes'] ?? '');
  $dislikes = trim($_POST['dislikes'] ?? '');

  $stmt = $pdo->prepare("
    UPDATE user_preferences
    SET spice_level = :spice, diet = :diet, likes = :likes, dislikes = :dislikes
    WHERE user_id = :uid
  ");
  $stmt->execute([
    'spice' => $spice,
    'diet' => $diet,
    'likes' => $likes,
    'dislikes' => $dislikes,
    'uid' => $user_id
  ]);

  $message = "Preferences saved ✅";
}

// Load current preferences
$stmt = $pdo->prepare("SELECT * FROM user_preferences WHERE user_id = :uid");
$stmt->execute(['uid' => $user_id]);
$prefs = $stmt->fetch() ?: ['spice_level'=>'medium','diet'=>'none','likes'=>'','dislikes'=>''];
?>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Your Profile</title>
  <link rel="stylesheet" href="styles.css" />
  <style>
    .wrap{max-width:900px;margin:0 auto;padding:22px}
    .card{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.10);border-radius:18px;padding:16px}
    .grid{display:grid;grid-template-columns:1fr 1fr;gap:12px}
    .input,.select,.textarea{width:100%}
    .msg{color:#9ff3d7;margin:10px 0}
  </style>
</head>
<body>
  <div class="wrap">
    <div class="topbar" style="position:static">
      <div class="brand">
        <span class="logo">🍲</span>
        <div>
          <div class="brand-title">Wasfatna</div>
          <div class="brand-sub">Profile Preferences</div>
        </div>
      </div>
      <nav class="nav">
        <a class="nav-link" href="index.php">Home</a>
        <a class="nav-link" href="signout.php">Sign out</a>
      </nav>
    </div>

    <div class="card" style="margin-top:14px">
      <h2 style="margin:0 0 6px">Hi, <?= htmlspecialchars($_SESSION['username']) ?> 👋</h2>
      <p class="muted">Tell us what you like, so we can personalize recipes for you.</p>

      <?php if ($message): ?><div class="msg"><?= htmlspecialchars($message) ?></div><?php endif; ?>

      <form method="POST">
        <div class="grid">
          <div>
            <label class="label">Spice level</label>
            <select class="select" name="spice_level">
              <option value="mild"   <?= $prefs['spice_level']==='mild'?'selected':'' ?>>Mild</option>
              <option value="medium" <?= $prefs['spice_level']==='medium'?'selected':'' ?>>Medium</option>
              <option value="spicy"  <?= $prefs['spice_level']==='spicy'?'selected':'' ?>>Spicy</option>
            </select>
          </div>
          <div>
            <label class="label">Diet</label>
            <select class="select" name="diet">
              <option value="none" <?= $prefs['diet']==='none'?'selected':'' ?>>None</option>
              <option value="vegetarian" <?= $prefs['diet']==='vegetarian'?'selected':'' ?>>Vegetarian</option>
              <option value="gluten-free" <?= $prefs['diet']==='gluten-free'?'selected':'' ?>>Gluten-Free</option>
              <option value="lactose-free" <?= $prefs['diet']==='lactose-free'?'selected':'' ?>>Lactose-Free</option>
            </select>
          </div>
        </div>

        <label class="label" style="margin-top:10px">Foods you like (comma separated)</label>
        <textarea class="textarea" name="likes" rows="3" placeholder="e.g., chicken, pasta, spicy food"><?= htmlspecialchars($prefs['likes'] ?? '') ?></textarea>

        <label class="label">Foods you dislike / allergies (comma separated)</label>
        <textarea class="textarea" name="dislikes" rows="3" placeholder="e.g., shrimp, peanuts"><?= htmlspecialchars($prefs['dislikes'] ?? '') ?></textarea>

        <div class="row">
          <button class="btn btn-primary" type="submit">Save</button>
          <a class="btn btn-outline" href="index.php">Back to recipes</a>
        </div>
      </form>
    </div>
  </div>
</body>
</html>