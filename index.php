<?php
require 'config.php';
require 'auth.php';

/*
 * ---------- Recipe of the Day ----------
 * Select one recipe from the database.
 * The recipe changes once per day.
 */

$recipeOfDay = null;

try {

    $countStmt = $pdo->query("
        SELECT COUNT(*)
        FROM recipes
    ");

    $recipeCount =
        (int)$countStmt->fetchColumn();

    if ($recipeCount > 0) {

        // Same recipe for the whole day.
        $dayNumber =
            (int)date('z');

        $recipeOffset =
            $dayNumber % $recipeCount;

        $recipeStmt = $pdo->query("
            SELECT
                recipe_id,
                recipe_name,
                description,
                prep_time,
                cook_time,
                servings,
                difficulty,
                image
            FROM recipes
            ORDER BY recipe_id
            LIMIT 1 OFFSET $recipeOffset
        ");

        $recipeOfDay =
            $recipeStmt->fetch();
    }

} catch (Throwable $error) {

    // The homepage should still work
    // even if the recipe cannot be loaded.
    $recipeOfDay = null;
}
  /*
 * ---------- Smart Recommended for You ----------
 */

$recommendedRecipes = [];

if (
    is_logged_in() &&
    !empty($_SESSION['user_id'])
) {
    try {

        $userId =
            (int)$_SESSION['user_id'];

        /*
         * Load the user's preferences.
         */
        $prefStmt = $pdo->prepare("
            SELECT
                spice_level,
                diet,
                likes,
                dislikes
            FROM user_preferences
            WHERE user_id = :user_id
            LIMIT 1
        ");

        $prefStmt->execute([
            ':user_id' => $userId
        ]);

        $preferences =
            $prefStmt->fetch();

        if ($preferences) {

            $userSpice =
                strtolower(
                    trim(
                        $preferences['spice_level'] ?? ''
                    )
                );

            $userDiet =
                strtolower(
                    trim(
                        $preferences['diet'] ?? ''
                    )
                );

            /*
             * Convert likes and dislikes into arrays.
             *
             * Example:
             * chicken, rice, pasta
             */
            $userLikes = array_values(
                array_filter(
                    array_map(
                        static fn($item) =>
                            strtolower(trim($item)),
                        explode(
                            ',',
                            $preferences['likes'] ?? ''
                        )
                    )
                )
            );

            $userDislikes = array_values(
                array_filter(
                    array_map(
                        static fn($item) =>
                            strtolower(trim($item)),
                        explode(
                            ',',
                            $preferences['dislikes'] ?? ''
                        )
                    )
                )
            );

            /*
             * Load recipes and their ingredients.
             */
            $recommendStmt = $pdo->query("
                SELECT
                    r.recipe_id,
                    r.recipe_name,
                    r.description,
                    r.prep_time,
                    r.cook_time,
                    r.servings,
                    r.difficulty,
                    r.image,
                    r.spice_level,
                    r.diet,

                    GROUP_CONCAT(
                        DISTINCT i.ingredient_name
                        SEPARATOR ', '
                    ) AS ingredient_names

                FROM recipes r

                LEFT JOIN recipe_ingredients ri
                    ON ri.recipe_id = r.recipe_id

                LEFT JOIN ingredients i
                    ON i.ingredient_id =
                       ri.ingredient_id

                GROUP BY
                    r.recipe_id,
                    r.recipe_name,
                    r.description,
                    r.prep_time,
                    r.cook_time,
                    r.servings,
                    r.difficulty,
                    r.image,
                    r.spice_level,
                    r.diet
            ");

            $allRecipes =
                $recommendStmt->fetchAll();

            $scoredRecipes = [];

            foreach ($allRecipes as $recipe) {

                $score = 0;

                $recipeName =
                    strtolower(
                        $recipe['recipe_name'] ?? ''
                    );

                $description =
                    strtolower(
                        $recipe['description'] ?? ''
                    );

                $ingredients =
                    strtolower(
                        $recipe['ingredient_names'] ?? ''
                    );

                $recipeSpice =
                    strtolower(
                        trim(
                            $recipe['spice_level'] ?? ''
                        )
                    );

                $recipeDiet =
                    strtolower(
                        str_replace(
                            ' ',
                            '',
                            $recipe['diet'] ?? ''
                        )
                    );

                /*
                 * ---------- Diet ----------
                 *
                 * Dietary preference is treated as a
                 * requirement rather than just a bonus.
                 */
                if (
                    $userDiet !== '' &&
                    $userDiet !== 'none' &&
                    $userDiet !== 'any'
                ) {

                    $cleanUserDiet =
                        str_replace(
                            ' ',
                            '',
                            $userDiet
                        );

                    $recipeDietList =
                        array_map(
                            'trim',
                            explode(
                                ',',
                                $recipeDiet
                            )
                        );

                    if (
                        !in_array(
                            $cleanUserDiet,
                            $recipeDietList,
                            true
                        )
                    ) {
                        /*
                         * Recipe does not satisfy the
                         * user's diet, so don't recommend it.
                         */
                        continue;
                    }

                    $score += 50;
                }

                /*
                 * ---------- Spice ----------
                 */
                if (
                    $userSpice !== '' &&
                    $userSpice !== 'any' &&
                    $recipeSpice === $userSpice
                ) {
                    $score += 25;
                }

                /*
                 * Searchable recipe text.
                 */
                $recipeText =
                    $recipeName . ' ' .
                    $description . ' ' .
                    $ingredients;

                /*
                 * ---------- Likes ----------
                 *
                 * Give points when a liked food appears
                 * in the recipe name, description
                 * or ingredients.
                 */
                foreach ($userLikes as $like) {

                    if (
                        $like !== '' &&
                        str_contains(
                            $recipeText,
                            $like
                        )
                    ) {
                        $score += 15;
                    }
                }

                /*
                 * ---------- Dislikes ----------
                 *
                 * Do not recommend recipes containing
                 * foods the user dislikes.
                 */
                $containsDislike = false;

                foreach ($userDislikes as $dislike) {

                    if (
                        $dislike !== '' &&
                        str_contains(
                            $recipeText,
                            $dislike
                        )
                    ) {
                        $containsDislike = true;
                        break;
                    }
                }

                if ($containsDislike) {
                    continue;
                }

                /*
                 * Add the calculated score.
                 */
                $recipe['recommendation_score'] =
                    $score;

                $scoredRecipes[] =
                    $recipe;
            }

            /*
             * Highest score first.
             */
            usort(
                $scoredRecipes,
                static function ($a, $b) {

                    $scoreA =
                        (int)(
                            $a[
                                'recommendation_score'
                            ] ?? 0
                        );

                    $scoreB =
                        (int)(
                            $b[
                                'recommendation_score'
                            ] ?? 0
                        );

                    if ($scoreA !== $scoreB) {
                        return $scoreB <=> $scoreA;
                    }

                    /*
                     * If scores are equal,
                     * sort alphabetically.
                     */
                    return strcasecmp(
                        $a['recipe_name'],
                        $b['recipe_name']
                    );
                }
            );

            /*
             * Keep the best 3 recipes.
             */
            $recommendedRecipes =
                array_slice(
                    $scoredRecipes,
                    0,
                    3
                );
        }

    } catch (Throwable $error) {

        $recommendedRecipes = [];
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
  <title>Wasfatna — Dynamic Meal Suggestion</title>
  <link rel="stylesheet" href="styles.css?v=31" />
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

  <main id="home">
    <!-- Hero Section -->
<section class="main-hero">

  <div class="main-hero-content">

   <div class="main-hero-text">

  <?php if (is_logged_in() && !empty($_SESSION['username'])): ?>

    <div class="welcome-user">

      <div class="welcome-user-title">
        Welcome back,
        <?= htmlspecialchars($_SESSION['username']) ?> 👋
      </div>

      <div class="welcome-user-text">
        Ready to find something delicious?
      </div>

    </div>

  <?php endif; ?>

  <div class="main-hero-label">
    🍲 Smart Recipe Suggestions
  </div>

      <h1>
        Cook delicious meals with what you already have.
      </h1>

      <p>
  Enter the ingredients available in your kitchen and Wasfatna
  will recommend recipes based on your preferences.
</p>

<?php if ($recipeOfDay): ?>

<div class="hero-recipe-day">

  <div class="hero-recipe-day-label">
    🍽 Recipe of the Day
  </div>

  <div class="hero-recipe-day-name">
    <?= htmlspecialchars($recipeOfDay['recipe_name']) ?>
  </div>

  <div class="hero-recipe-day-meta">

    <span>
      ⭐ <?= htmlspecialchars(
        $recipeOfDay['difficulty'] ?? 'Not specified'
      ) ?>
    </span>

    <span>
      ⏱ <?= (int)(
        ($recipeOfDay['prep_time'] ?? 0) +
        ($recipeOfDay['cook_time'] ?? 0)
      ) ?> min
    </span>

    <span>
      🍽 Serves <?= htmlspecialchars(
        $recipeOfDay['servings'] ?? 'N/A'
      ) ?>
    </span>

  </div>

    <a
  href="find.php?recipe_id=<?= (int)$recipeOfDay['recipe_id'] ?>"
  class="hero-recipe-day-link"
>
  View Recipe →
</a>

</div>

<?php endif; ?>

<a
  href="find.php"
  class="btn btn-primary main-hero-button"
>
  Find My Recipe →
</a>

    </div>

    <div class="main-hero-image-wrapper">

  <img
    id="homeRecipeSlider"
    src="images/chicken_machboos.png"
    alt="Featured Wasfatna recipe"
    class="main-hero-image"
  >

  <div class="main-hero-slider-dots">

    <button
      type="button"
      class="home-slider-dot active"
      data-slide="0"
      aria-label="Show recipe image 1"
    ></button>

    <button
      type="button"
      class="home-slider-dot"
      data-slide="1"
      aria-label="Show recipe image 2"
    ></button>

    <button
      type="button"
      class="home-slider-dot"
      data-slide="2"
      aria-label="Show recipe image 3"
    ></button>

    <button
      type="button"
      class="home-slider-dot"
      data-slide="3"
      aria-label="Show recipe image 4"
    ></button>

  </div>

</div>

  </div>

</section>

      <?php if (!empty($recommendedRecipes)): ?>

<section class="recommended-section">

  <div class="recommended-header">

    <div>
      <div class="recommended-label">
        ✨ Recommended for You
      </div>

      <h2>
        Recipes picked for your preferences
      </h2>

      <p>
        Based on your saved dietary and spice preferences.
      </p>
    </div>

  </div>

  <div class="recommended-grid">

    <?php foreach ($recommendedRecipes as $recipe): ?>

      <?php

      $image =
          !empty($recipe['image'])
            ? $recipe['image']
            : 'default_recipe.png';

      $totalTime =
          (int)($recipe['prep_time'] ?? 0) +
          (int)($recipe['cook_time'] ?? 0);

      ?>

      <article class="recommended-card">

        <img
          src="images/<?= htmlspecialchars($image) ?>"
          alt="<?= htmlspecialchars(
            $recipe['recipe_name']
          ) ?>"
          class="recommended-image"
          onerror="this.onerror=null;this.src='images/default_recipe.png';"
        >

        <div class="recommended-card-content">

          <h3>
            <?= htmlspecialchars(
              $recipe['recipe_name']
            ) ?>
          </h3>

          <div class="recommended-meta">

            <span>
              ⭐
              <?= htmlspecialchars(
                $recipe['difficulty']
                  ?? 'Unknown'
              ) ?>
            </span>

            <span>
              ⏱ <?= $totalTime ?> min
            </span>

            <span>
              🍽 Serves
              <?= htmlspecialchars(
                $recipe['servings']
                  ?? 'N/A'
              ) ?>
            </span>

          </div>

          <a
            href="find.php?recipe_id=<?= (int)$recipe['recipe_id'] ?>"
            class="btn btn-primary recommended-button"
          >
            View Recipe →
          </a>

        </div>

      </article>

    <?php endforeach; ?>

  </div>

</section>

<?php endif; ?>

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

  <section class="about-section">

    <div class="about-section-heading">
      <span class="about-section-icon">📖</span>

      <div>
        <h3>About Wasfatna</h3>
        <p class="muted">
          Smart Meal Suggestions
        </p>
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
        <p class="muted">
          What you can do with Wasfatna
        </p>
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
        Shopping list and recipe printing
      </div>

      <div class="about-feature-item">
        <span>✓</span>
        Dietary and spice preferences
      </div>

      <div class="about-feature-item">
        <span>✓</span>
        Dark and light display modes
      </div>

    </div>

  </section>

  <section class="about-section">

    <div class="about-section-heading">
      <span class="about-section-icon">👨‍💻</span>

      <div>
        <h3>Team Members</h3>
        <p class="muted">
          University of Bahrain
        </p>
      </div>
    </div>

    <div class="cv-card">
      <div class="cv-avatar">A</div>

      <div>
        <div class="cv-name">
          Ahammed Ismail
        </div>

        <div class="muted">
          202201478
        </div>
      </div>
    </div>

    <div class="cv-card">
      <div class="cv-avatar">B</div>

      <div>
        <div class="cv-name">
          Bilal Mohammad Tofeeq
        </div>

        <div class="muted">
          202200507
        </div>
      </div>
    </div>

    <div class="cv-card">
      <div class="cv-avatar">B</div>

      <div>
        <div class="cv-name">
          Bassem Mohammad Irshad Mohammed Islam
        </div>

        <div class="muted">
          202201552
        </div>
      </div>
    </div>

  </section>

  <div class="about-project-info">

    <strong>
      University of Bahrain
    </strong>

    <span>
      Senior Project 2025–2026
    </span>

    <span>
      Wasfatna Version 1.0
    </span>

  </div>

</div>
  </aside>

  <div id="backdrop" class="backdrop" hidden></div>
  <script src="app.js?v=12"></script>
</body>
</html>


