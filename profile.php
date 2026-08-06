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
// Count the user's favorite recipes.
$stmt = $pdo->prepare("
  SELECT COUNT(*)
  FROM favorites
  WHERE user_id = :uid
");

$stmt->execute([
  'uid' => $user_id
]);

$favorite_count = (int)$stmt->fetchColumn();
?>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Your Profile</title>
  <link rel="stylesheet" href="styles.css?v=21" />
  <script>var t=localStorage.getItem("wasfatna-theme");if(t)document.documentElement.setAttribute("data-theme",t);</script>
</head>
<body>

<header class="topbar profile-topbar">

  <a href="index.php" class="brand">
    <span class="logo">🍲</span>

    <div>
      <div class="brand-title">
        Wasfatna
      </div>

      <div class="brand-sub">
        Profile Preferences
      </div>
    </div>
  </a>

  <nav class="nav">

    <a class="nav-link" href="index.php">
      Home
    </a>

    <a class="nav-link" href="find.php">
      Find Recipes
    </a>

    <a class="nav-link" href="favorites.php">
      My Favorites
    </a>

    <button
      id="themeToggle"
      class="btn btn-ghost btn-small"
      type="button"
    >
      🌙 Dark
    </button>

    <a class="nav-link" href="signout.php">
      Sign out
    </a>

  </nav>

</header>

<main class="profile-page">

  <section class="profile-heading">

    <div>
      <div class="profile-label">
        👤 My Profile
      </div>

      <h1>
        Hi, <?= htmlspecialchars($_SESSION['username']) ?> 👋
      </h1>

      <p>
        Manage your food preferences to receive more personalized
        recipe recommendations.
      </p>
    </div>

  </section>

  <?php if ($message): ?>
    <div class="profile-success-message" role="status">
      ✅ <?= htmlspecialchars($message) ?>
    </div>
  <?php endif; ?>

  <div class="profile-dashboard">

    <!-- Profile Summary -->
    <aside class="profile-summary-card">

      <div class="profile-avatar">
        <?= strtoupper(
          htmlspecialchars(
            substr($_SESSION['username'], 0, 1)
          )
        ) ?>
      </div>

      <h2>
        <?= htmlspecialchars($_SESSION['username']) ?>
      </h2>

      <p class="muted">
        Wasfatna member
      </p>

      <div class="profile-stat">

        <div class="profile-stat-icon">
          ❤️
        </div>

        <div>
          <span>Favorite Recipes</span>

          <strong>
            <?= $favorite_count ?>
          </strong>
        </div>

      </div>

      <div class="profile-stat">

        <div class="profile-stat-icon">
          🌶️
        </div>

        <div>
          <span>Spice Preference</span>

          <strong>
            <?= htmlspecialchars(
              ucfirst($prefs['spice_level'])
            ) ?>
          </strong>
        </div>

      </div>

      <div class="profile-stat">

        <div class="profile-stat-icon">
          🥗
        </div>

        <div>
          <span>Diet</span>

          <strong>
            <?= htmlspecialchars(
              ucwords(
                str_replace('-', ' ', $prefs['diet'])
              )
            ) ?>
          </strong>
        </div>

      </div>

      <a
        href="favorites.php"
        class="btn btn-outline profile-favorites-btn"
      >
        ❤️ View My Favorites
      </a>

    </aside>

    <!-- Preferences Form -->
    <section class="profile-preferences-card">

      <div class="profile-card-header">

        <div>
          <h2>
            🍽 Food Preferences
          </h2>

          <p class="muted">
            Update these settings to improve your recipe suggestions.
          </p>
        </div>

      </div>

      <form method="POST" id="profileForm">

        <div class="profile-form-grid">

          <div>
            <label class="label" for="profileSpice">
              Spice Level
            </label>

            <select
              id="profileSpice"
              class="select"
              name="spice_level"
            >
              <option
                value="mild"
                <?= $prefs['spice_level'] === 'mild'
                  ? 'selected'
                  : '' ?>
              >
                Mild
              </option>

              <option
                value="medium"
                <?= $prefs['spice_level'] === 'medium'
                  ? 'selected'
                  : '' ?>
              >
                Medium
              </option>

              <option
                value="spicy"
                <?= $prefs['spice_level'] === 'spicy'
                  ? 'selected'
                  : '' ?>
              >
                Spicy
              </option>
            </select>
          </div>

          <div>
            <label class="label" for="profileDiet">
              Dietary Preference
            </label>

            <select
              id="profileDiet"
              class="select"
              name="diet"
            >
              <option
                value="none"
                <?= $prefs['diet'] === 'none'
                  ? 'selected'
                  : '' ?>
              >
                None
              </option>

              <option
                value="vegetarian"
                <?= $prefs['diet'] === 'vegetarian'
                  ? 'selected'
                  : '' ?>
              >
                Vegetarian
              </option>

              <option
                value="non-vegetarian"
                <?= $prefs['diet'] === 'non-vegetarian'
                  ? 'selected'
                  : '' ?>
              >
                Non-Vegetarian
              </option>

              <option
                value="gluten-free"
                <?= $prefs['diet'] === 'gluten-free'
                  ? 'selected'
                  : '' ?>
              >
                Gluten-Free
              </option>

              <option
                value="lactose-free"
                <?= $prefs['diet'] === 'lactose-free'
                  ? 'selected'
                  : '' ?>
              >
                Lactose-Free
              </option>
            </select>
          </div>

        </div>

        <div class="profile-field">

          <label class="label" for="profileLikes">
            Foods You Like
          </label>

          <p class="profile-field-help">
            Separate multiple foods using commas.
          </p>

          <textarea
            id="profileLikes"
            class="textarea"
            name="likes"
            rows="4"
            placeholder="e.g., chicken, pasta, spicy food"
          ><?= htmlspecialchars($prefs['likes'] ?? '') ?></textarea>

        </div>

        <div class="profile-field">

          <label class="label" for="profileDislikes">
            Foods You Dislike or Are Allergic To
          </label>

          <p class="profile-field-help">
            These ingredients can be avoided in recommendations.
          </p>

          <textarea
            id="profileDislikes"
            class="textarea"
            name="dislikes"
            rows="4"
            placeholder="e.g., shrimp, peanuts"
          ><?= htmlspecialchars($prefs['dislikes'] ?? '') ?></textarea>

        </div>

        <div class="profile-actions">

          <button
            class="btn btn-primary"
            type="submit"
            id="saveProfileBtn"
          >
            Save Preferences
          </button>

          <button
            class="btn btn-outline"
            type="reset"
          >
            Undo Changes
          </button>

          <a
            class="btn btn-outline"
            href="find.php"
          >
            Back to Recipes
          </a>

        </div>

      </form>

    </section>

  </div>

</main>

<footer class="footer profile-footer">
  <div>
    © 2025/2026 — University of Bahrain — Senior Project
  </div>
</footer>
  <script src="app.js?v=16"></script>
</body>
</html>
