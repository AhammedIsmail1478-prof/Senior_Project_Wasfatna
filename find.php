<?php
require 'auth.php';
?>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Wasfatna — Find Your Recipe</title>
  <link rel="stylesheet" href="styles.css?v=43" />
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

  <a href="index.php" class="nav-link">
    Home
  </a>

  <a href="find.php" class="nav-link">
    Find Recipes
  </a>

  <?php if (is_logged_in()): ?>

    <a href="favorites.php" class="nav-link">
      My Favorites
    </a>

    <a href="profile.php" class="nav-link">
      Profile
    </a>

  <?php else: ?>

    <a href="signin.php" class="nav-link">
      Sign in
    </a>

    <a href="signup.php" class="nav-link">
      Sign up
    </a>

  <?php endif; ?>

  <button
    type="button"
    id="shoppingListBtn"
    class="nav-link nav-button"
  >
    🛒 Shopping List
    <span id="shoppingListCount" class="shopping-count">0</span>
  </button>

  <button
    type="button"
    id="themeToggle"
    class="nav-link nav-button"
  >
    🌙 Dark
  </button>

  <button
    type="button"
    id="aboutBtn"
    class="nav-link nav-button"
  >
    About / CVs
  </button>

  <?php if (is_logged_in()): ?>

    <a href="signout.php" class="nav-link">
      Sign out
    </a>

  <?php endif; ?>

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
        <div class="left-search-column">

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
  <button
    type="button"
    id="suggestBtn"
    class="btn btn-primary"
  >
    Suggest Recipes
  </button>

  <button
    type="button"
    id="voiceSearchBtn"
    class="btn btn-outline"
    aria-label="Speak ingredients"
    title="Speak ingredients"
  >
    🎤 Speak Ingredients
  </button>

  <button
    type="button"
    id="randomRecipeBtn"
    class="btn btn-outline"
    disabled
  >
    🎲 Surprise Me
  </button>

  <button
    type="button"
    id="clearBtn"
    class="btn btn-outline"
  >
    Clear
  </button>
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
                <option value="healthier">Healthier</option>
                <option value="high-protein">High Protein</option>
                <option value="low-cal">Lower Calories</option>
              </select>
            </div>

            <div>
              <label class="label">Dietary</label>
              <select id="diet" class="select">
                <option value="none">None</option>
                <option value="vegetarian">Vegetarian</option>
                <option value="non-vegetarian">Non-Vegetarian</option>
                <option value="gluten-free">Gluten-Free</option>
                <option value="lactose-free">Lactose-Free</option>
              </select>
            </div>
          </div>
        </div>

         <!-- Smart Search Summary -->
        <div
          id="smartSearchSummary"
          class="smart-search-summary"
          hidden
        >

          <div class="smart-summary-section">

  <div class="smart-summary-label">
    Current ingredients
  </div>

  <div
    id="summaryIngredients"
    class="smart-summary-value smart-current-ingredients"
  >
    None
  </div>

</div>


<div class="smart-summary-meta">

  <div class="smart-match-count">
    🍽
    <strong id="summaryRecipeCount">0</strong>
    matching recipes
  </div>

  <div class="smart-preference-chips">

    <span class="smart-preference-chip">
  🌶 Spice:
  <span id="summarySpice">Any</span>
</span>

<span class="smart-preference-chip">
  🎯 Goal:
  <span id="summaryGoal">Any</span>
</span>

<span class="smart-preference-chip">
  🥗 Diet:
  <span id="summaryDiet">None</span>
</span>

  </div>

</div>


<div class="smart-summary-section">

  <div class="smart-summary-label">
    Recommended next ingredients
  </div>

  <div class="smart-summary-hint">
    Frequently needed by your matching recipes
  </div>

  <div
    id="smartIngredientSuggestions"
    class="smart-ingredient-suggestions"
  >
    No suggestions yet.
  </div>

</div>

        </div>
        </div>

        <!-- Results Panel -->
        <div class="panel">
          <div class="stats-grid">

  <div class="stat-card">
    <div class="stat-icon">🍽</div>
    <div class="stat-title">Recipes Found</div>
    <div class="stat-number" id="statsRecipes">0</div>
  </div>

  <div class="stat-card">
    <div class="stat-icon">❤️</div>
    <div class="stat-title">Favorites</div>
    <div class="stat-number" id="statsFavorites">0</div>
  </div>

  <div class="stat-card">
    <div class="stat-icon">🥬</div>
    <div class="stat-title">Ingredients Entered</div>
    <div class="stat-number" id="statsIngredients">0</div>
  </div>

</div>
          <div class="results-header">
            <h3>Results</h3>
            <span id="resultsCount" class="badge">0</span>
          </div>
          <div class="results-tools">

  <div class="recipe-search-wrapper">
    <input
      type="search"
      id="recipeSearch"
      class="recipe-search-input"
      placeholder="🔍 Search recipes or ingredients..."
      list="recipeSuggestions"
      autocomplete="off"
    />

    <datalist id="recipeSuggestions"></datalist>
  </div>

  <div class="recipe-controls">

    <select
      id="recipeSort"
      class="recipe-sort-input"
      aria-label="Sort recipe results"
    >
      <option value="best-match">
        Best Match
      </option>

      <option value="name-asc">
        Name: A–Z
      </option>

      <option value="name-desc">
        Name: Z–A
      </option>

      <option value="most-matched">
        Most Ingredients Matched
      </option>

      <option value="lowest-match">
        Lowest Match First
      </option>
    </select>

    <select
      id="recipeFilter"
      class="recipe-filter-input"
      aria-label="Filter recipe results"
    >
      <option value="all">
        All Recipes
      </option>

      <option value="perfect">
        100% Match
      </option>

      <option value="excellent">
        90–99% Match
      </option>

      <option value="good">
        75–89% Match
      </option>

      <option value="partial">
        50–74% Match
      </option>

      <option value="low">
        Below 50%
      </option>

      <option value="ready">
        Ready to Cook
      </option>

      <option value="missing-core">
        Missing Core Ingredients
      </option>

      <option value="favorites">
        Favorites Only
      </option>
    </select>

  </div>

</div>
<div
  class="recipe-navigation"
  id="recipeNavigation"
  style="display: none;"
>
  <button
    type="button"
    id="prevRecipeBtn"
    class="btn btn-outline"
  >
    ← Previous
  </button>

  <span id="recipePageInfo"></span>

  <button
    type="button"
    id="nextRecipeBtn"
    class="btn btn-primary"
  >
    Next →
  </button>
</div>

<div id="results" class="results">
  <div class="empty">
    Enter ingredients and click "Suggest Recipes".
  </div>
</div>
        </div>

            </div>

      <!-- Recently Viewed Recipes -->
      <div
        id="recentlyViewedSection"
        class="recently-viewed-section"
        hidden
      >
        <div class="recently-viewed-header">
          <h3>Recently Viewed</h3>

          <button
            type="button"
            id="clearRecentlyViewedBtn"
            class="btn btn-outline btn-small"
          >
            Clear History
          </button>
        </div>

        <div
          id="recentlyViewedList"
          class="recently-viewed-list"
        ></div>
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
<!-- Shopping List Side Panel -->
<aside
  id="shoppingListPanel"
  class="sidepanel"
  aria-hidden="true"
>
  <div class="sidepanel-top">
    <div class="sidepanel-title">
      🛒 Shopping List
    </div>

    <button
      type="button"
      id="shoppingListClose"
      class="btn btn-ghost"
    >
      ✕
    </button>
  </div>

  <div class="sidepanel-content">

    <div id="shoppingListItems" class="shopping-list-items">
      <div class="empty">
        Your shopping list is empty.
      </div>
    </div>

    <div class="shopping-actions">

    <button
        type="button"
        id="printShoppingListBtn"
        class="btn btn-primary">
        🖨 Print
    </button>

    <button
        type="button"
        id="downloadShoppingPdfBtn"
        class="btn btn-outline">
        📄 Download PDF
    </button>

    <button
        type="button"
        id="clearShoppingListBtn"
        class="btn btn-outline">
        Clear Shopping List
    </button>

</div>
  </div>
</aside>
  
  <div id="backdrop" class="backdrop" hidden></div>
<div id="toast" class="toast">
    <span id="toastIcon">❤️</span>
    <span id="toastMessage"></span>
</div>

<script
  src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/3.0.2/jspdf.umd.min.js"
></script>

<script
  src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.9.3/dist/confetti.browser.min.js"
></script>

<script>
  window.initialRecipeId =
    <?= isset($_GET['recipe_id'])
      ? (int)$_GET['recipe_id']
      : 0 ?>;
</script>

<script src="app.js?v=27"></script>

</body>
</html>
