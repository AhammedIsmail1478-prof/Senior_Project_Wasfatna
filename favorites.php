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

<script src="favorites.js?v=2"></script>

</body>
</html>
