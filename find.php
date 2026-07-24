<?php
require 'auth.php';
?>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Wasfatna — Find Your Recipe</title>
  <link rel="stylesheet" href="styles.css?v=10" />
  <script>var t=localStorage.getItem("wasfatna-theme");if(t)document.documentElement.setAttribute("data-theme",t);</script>
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
      <a href="profile.php" class="nav-link">Profile</a>
      <?php if (is_logged_in()): ?>
        <a href="signout.php" class="nav-link">Sign out</a>
      <?php else: ?>
        <a href="signin.php" class="nav-link">Sign in</a>
        <a href="signup.php" class="nav-link">Sign up</a>
      <?php endif; ?>
      <button id="themeToggle" class="btn btn-ghost btn-small">🌙 Dark</button>
      <button id="aboutBtn" class="btn btn-ghost">About / CVs</button>
    </nav>
  </header>

  <main class="container">
    <!-- Find Your Recipe Section -->
    <section class="section">
     <h2>Find Your Recipe</h2>
      <p class="muted">
        Add ingredients you have and customize your preferences.
      </p>

      <div class="grid-2">

        <!-- User Input Panel -->
        <div class="panel">
          <h3>Your Ingredients</h3>

          <label class="label">Ingredients (comma separated)</label>
          <textarea
            id="ingredientsInput"
            class="textarea"
            rows="4"
            placeholder="e.g., chicken, rice, onion"
          ></textarea>

          <div class="row">
            <button id="suggestBtn" class="btn btn-primary">Suggest Recipes</button>
            <button id="clearBtn" class="btn btn-outline">Clear</button>
          </div>

          <hr class="hr"/>

          <h3>Preferences</h3>

          <div class="form-grid">
            <div>
              <label class="label">Spice Level</label>
              <select id="spice" class="select">
                <option value="any">Any</option>
                <option value="mild">Mild</option>
                <option value="medium">Medium</option>
                <option value="spicy">Spicy</option>
              </select>
            </div>

            <div>
              <label class="label">Goal</label>
              <select id="goal" class="select">
                <option value="any">Any</option>
                <option value="healthy">Healthier</option>
                <option value="high-protein">High Protein</option>
                <option value="low-cal">Lower Calories</option>
              </select>
            </div>

            <div>
              <label class="label">Dietary</label>
              <select id="diet" class="select">
                <option value="none">None</option>
                <option value="vegetarian">Vegetarian</option>
                <option value="gluten-free">Gluten-Free</option>
                <option value="lactose-free">Lactose-Free</option>
              </select>
            </div>
          </div>
        </div>

        <!-- Results Panel -->
        <div class="panel">
          <div class="results-header">
            <h3>Results</h3>
            <span id="resultsCount" class="badge">0</span>
          </div>

          <div id="results" class="results">
            <div class="empty">
              Enter ingredients and click "Suggest Recipes".
            </div>
          </div>
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
        <div class="sidepanel-title">About &amp; CVs</div>
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
  <script src="app.js?v=10"></script>
</body>
</html>
