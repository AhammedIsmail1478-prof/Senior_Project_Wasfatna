<?php
session_start();

if (!isset($_SESSION['user_id'])) {
    header('Location: signin.php');
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0"
    >

    <title>My Favorites | Wasfatna</title>

    <script>
        const savedTheme =
            localStorage.getItem("wasfatna-theme") ||
            "dark";

        document.documentElement.setAttribute(
            "data-theme",
            savedTheme
        );
    </script>

    <link rel="stylesheet" href="styles.css?v=17">
</head>

<body>

<header class="topbar">

    <a
        href="index.php"
        class="brand"
    >
        <span class="logo">🍲</span>

        <div>
            <div class="brand-title">
                Wasfatna
            </div>

            <div class="brand-sub">
                Smart Meal Suggestions
            </div>
        </div>
    </a>

    <nav class="nav">
        <a href="index.php" class="nav-link">
  Home
</a>

        <a
            class="nav-link"
            href="find.php"
        >
            Find Recipes
        </a>

        <a
            class="nav-link"
            href="favorites.php"
        >
            My Favorites
        </a>

        <a
            class="nav-link"
            href="profile.php"
        >
            Profile
        </a>

        <button
            type="button"
            class="btn btn-ghost btn-small"
            id="themeToggle"
        >
            🌙 Dark
        </button>

        <button
  id="aboutBtn"
  class="nav-link nav-button"
  type="button"
>
  About / CVs
</button>

        <a
            class="nav-link"
            href="signout.php"
        >
            Sign out
        </a>

    </nav>

</header>

<main class="container">

    <section class="section">

        <div class="results-header">

            <div>
                <h2>
                    My Favorite Recipes
                </h2>

                <p class="muted">
                    View and manage your saved recipes.
                </p>
            </div>

            <span
                class="badge"
                id="favoritesCount"
            >
                0
            </span>

        </div>

        <div
            id="favoritesResults"
            class="results"
        >
            <div class="empty">
                Loading your favorite recipes...
            </div>
        </div>

    </section>

</main>

<footer class="footer">

    <div class="container">
        Wasfatna — Smart Meal Suggestions
    </div>

</footer>

  <!-- About Side Panel -->
  <aside id="aboutPanel" class="sidepanel" aria-hidden="true">
    <div class="sidepanel-top">
      <div>
        <div class="sidepanel-title">About &amp; CVs</div>
      </div>
      <button
  type="button"
  id="aboutClose"
  class="btn btn-ghost"
>
  ✕
</button>
    </div>
   <div class="sidepanel-content">

  <section class="about-section">

    <div class="about-section-heading">
      <span class="about-section-icon">📖</span>

      <div>
        <h3>About Wasfatna</h3>
        <p class="muted">Smart Meal Suggestions</p>
      </div>
    </div>

    <p class="about-description">
      <strong>Wasfatna</strong> is a smart meal recommendation system
      developed as a University of Bahrain Senior Project. It helps users
      discover recipes using available ingredients while considering their
      dietary preferences and helping to reduce food waste.
    </p>

  </section>

  <section class="about-section">

    <div class="about-section-heading">
      <span class="about-section-icon">✨</span>

      <div>
        <h3>Key Features</h3>
        <p class="muted">What you can do with Wasfatna</p>
      </div>
    </div>

    <div class="about-feature-list">

      <div class="about-feature-item">
        <span>✓</span>
        Ingredient-based recipe search
      </div>

      <div class="about-feature-item">
        <span>✓</span>
        Personalized recipe recommendations
      </div>

      <div class="about-feature-item">
        <span>✓</span>
        Save and manage favorite recipes
      </div>

      <div class="about-feature-item">
        <span>✓</span>
        Dietary and spice preferences
      </div>

      <div class="about-feature-item">
  <span>✓</span>
  Ratings and recipe reviews
</div>
      
    </div>

  </section>

  <section class="about-section">

    <div class="about-section-heading">
      <span class="about-section-icon">👨‍💻</span>

      <div>
        <h3>Team Members</h3>
        <p class="muted">University of Bahrain</p>
      </div>
    </div>

    <div class="cv-card">
      <div class="cv-avatar">A</div>

      <div>
        <div class="cv-name">Ahammed Ismail</div>
        <div class="muted">202201478</div>
      </div>
    </div>

    <div class="cv-card">
      <div class="cv-avatar">B</div>

      <div>
        <div class="cv-name">Bilal Mohammad Tofeeq</div>
        <div class="muted">202200507</div>
      </div>
    </div>

    <div class="cv-card">
      <div class="cv-avatar">B</div>

      <div>
        <div class="cv-name">
          Bassem Mohammad Irshad Mohammed Islam
        </div>

        <div class="muted">202201552</div>
      </div>
    </div>

  </section>

  <div class="about-project-info">

    <strong>University of Bahrain</strong>

    <span>Senior Project 2025–2026</span>

    <span>Wasfatna Version 1.0</span>

  </div>

</div>
  </aside>
    
<script src="favorites.js?v=3"></script>
    <script>
  const aboutBtn = document.getElementById("aboutBtn");
  const aboutPanel = document.getElementById("aboutPanel");
  const aboutClose = document.getElementById("aboutClose");
  const backdrop = document.getElementById("backdrop");

  function openAbout() {
    aboutPanel.classList.add("open");
    aboutPanel.setAttribute("aria-hidden", "false");
    backdrop.hidden = false;
  }

  function closeAbout() {
    aboutPanel.classList.remove("open");
    aboutPanel.setAttribute("aria-hidden", "true");
    backdrop.hidden = true;
  }

  if (aboutBtn && aboutPanel && aboutClose && backdrop) {
    aboutBtn.addEventListener("click", openAbout);
    aboutClose.addEventListener("click", closeAbout);
    backdrop.addEventListener("click", closeAbout);
  }
</script>

</body>
</html>
