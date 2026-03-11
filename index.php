<?php 
require 'auth.php';
?>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Wasfatna — Dynamic Meal Suggestion</title>
  <link rel="stylesheet" href="styles.css" />
</head>

<body>
  <!-- Top Navigation -->
  <header class="topbar">
    <div class="brand">
      <span class="logo">🍲</span>
      <div>
        <div class="brand-title">Wasfatna</div>
        <div class="brand-sub">Smart Meal Suggestions</div>
      </div>
    </div>

    <nav class="nav">
      <?php if (is_logged_in()): ?>
        <a href="profile.php" class="nav-link">Profile</a>
        <a href="signout.php" class="nav-link">Sign out</a>
      <?php else: ?>
        <a href="signin.php" class="nav-link">Sign in</a>
        <a href="signup.php" class="nav-link">Sign up</a>
      <?php endif; ?>
      <button id="aboutBtn" class="btn btn-ghost">About / CVs</button>
    </nav>
  </header>

  <main id="home" class="container">
    <!-- Hero Section -->
    <section class="hero">
      <div class="hero-text">
        <h1>Cook smarter with what you already have.</h1>
        <p>
          Enter your ingredients and get personalized recipe suggestions
          based on your taste preferences and dietary needs.
        </p>
        <div class="hero-actions">
          <a class="btn btn-primary" href="find.php">Start Now</a>
        </div>
      </div>
    </section>

    <footer class="footer">
      <div>© 2025/2026 — University of Bahrain — Senior Project</div>
    </footer>
  </main>

  <!-- About Side Panel -->
  <aside id="aboutPanel" class="sidepanel" aria-hidden="true">
    <div class="sidepanel-top">
      <div>
        <div class="sidepanel-title">About & CVs</div>
      </div>
      <button id="aboutClose" class="btn btn-ghost">✕</button>
    </div>

    <div class="sidepanel-content">
      <p>
        Wasfatna is a smart recipe suggestion system that reduces food waste
        by recommending meals based on available ingredients and user preferences.
      </p>

      <h4>Team Members</h4>
      <div class="cv-card"><div class="cv-name">Ahammed Ismail</div><div class="muted">202201478</div></div>
      <div class="cv-card"><div class="cv-name">Bilal Mohammad Tofeeq</div><div class="muted">202200507</div></div>
      <div class="cv-card"><div class="cv-name">Bassem Mohammad Irshad Mohammed Islam</div><div class="muted">202201552</div></div>
    </div>
  </aside>

  <div id="backdrop" class="backdrop" hidden></div>
  <script src="app.js"></script>
</body>
</html>


