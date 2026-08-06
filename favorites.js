// ---------- Theme toggle ----------
const themeToggleBtn =
  document.getElementById("themeToggle");

function applyTheme(theme) {
  document.documentElement.setAttribute(
    "data-theme",
    theme
  );

  if (themeToggleBtn) {
    themeToggleBtn.textContent =
      theme === "light"
        ? "☀️ Light"
        : "🌙 Dark";
  }
}

const currentTheme =
  document.documentElement.getAttribute(
    "data-theme"
  ) || "dark";

applyTheme(currentTheme);

if (themeToggleBtn) {
  themeToggleBtn.addEventListener(
    "click",
    () => {
      const current =
        document.documentElement.getAttribute(
          "data-theme"
        );

      const next =
        current === "light"
          ? "dark"
          : "light";

      localStorage.setItem(
        "wasfatna-theme",
        next
      );

      applyTheme(next);
    }
  );
}

// ---------- Helpers ----------
function escapeHtml(value) {
  return String(value ?? "")
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}

function ingredientText(item) {
  const name = escapeHtml(
    item?.name ?? ""
  );

  const quantity = item?.quantity
    ? ` — ${escapeHtml(item.quantity)}`
    : "";

  return `${name}${quantity}`;
}

// ---------- Favorite recipes ----------
const favoritesResults =
  document.getElementById(
    "favoritesResults"
  );

const favoritesCount =
  document.getElementById(
    "favoritesCount"
  );

async function loadFavorites() {
  if (
    !favoritesResults ||
    !favoritesCount
  ) {
    return;
  }

  favoritesResults.innerHTML = `
    <div class="empty">
      Loading your favorite recipes...
    </div>
  `;

  try {
    const response = await fetch(
      "get_favorites.php"
    );

    const responseText =
      await response.text();

    let data;

    try {
      data = JSON.parse(responseText);
    } catch (error) {
      console.error(
        "Invalid favorites response:",
        responseText
      );

      throw new Error(
        "get_favorites.php did not return valid JSON."
      );
    }

    if (
      !response.ok ||
      data.success !== true
    ) {
      throw new Error(
        data.message ||
        "Unable to load favorites."
      );
    }

    const recipes =
      Array.isArray(data.recipes)
        ? data.recipes
        : [];

    favoritesCount.textContent =
      String(recipes.length);

    if (!recipes.length) {
      favoritesResults.innerHTML = `
        <div class="empty">
          You have not saved any favorite recipes yet.
          Go to Find Recipes and click the heart.
        </div>
      `;

      return;
    }

    favoritesResults.innerHTML =
      recipes
        .map((recipe) => {
          const recipeId =
            Number(recipe.recipe_id) || 0;

          const recipeName =
            recipe.recipe_name ||
            "Recipe";

          const imageFile =
            String(
              recipe.image || ""
            ).trim();

          const imagePath =
            imageFile !== ""
              ? `images/${encodeURIComponent(
                  imageFile
                )}`
              : "images/default_recipe.png";

          const ingredients =
            Array.isArray(
              recipe.ingredients
            )
              ? recipe.ingredients
              : [];

          const steps =
            Array.isArray(recipe.steps)
              ? recipe.steps
              : [];

          const ingredientsHtml =
            ingredients.length
              ? ingredients
                  .map(ingredientText)
                  .join(", ")
              : "No ingredients stored.";

          const stepsHtml =
            steps.length
              ? `
                <ol>
                  ${steps
                    .map(
                      (step) =>
                        `<li>${escapeHtml(
                          step
                        )}</li>`
                    )
                    .join("")}
                </ol>
              `
              : `
                <div class="small">
                  No steps stored.
                </div>
              `;

          const difficulty =
            String(
              recipe.difficulty ||
              "Unknown"
            );

          return `
            <article
              class="recipe"
              data-recipe-id="${recipeId}"
            >
              <div class="recipe-summary">

                <div class="recipe-image-wrapper">
  <img
    src="${imagePath}"
    alt="${escapeHtml(recipeName)}"
    class="recipe-image"
    loading="lazy"
    onerror="this.onerror=null; this.src='images/default_recipe.png';"
  >
</div>

                <div class="recipe-information">

                  <div class="recipe-title-row">

                    <h4>
                      ${escapeHtml(
                        recipeName
                      )}
                    </h4>

                    <button
                      type="button"
                      class="favorite-btn is-favorite"
                      data-recipe-id="${recipeId}"
                      aria-label="Remove from favorites"
                      title="Remove from favorites"
                    >
                      ❤️
                    </button>

                  </div>

                  <div class="recipe-details">

  <div class="recipe-time-item">
    ⏱ Prep:
    <strong>
      ${escapeHtml(
        recipe.prep_time || "Not specified"
      )}
      ${recipe.prep_time ? "min" : ""}
    </strong>
  </div>

  <div class="recipe-time-item">
    🔥 Cook:
    <strong>
      ${escapeHtml(
        recipe.cook_time || "Not specified"
      )}
      ${recipe.cook_time ? "min" : ""}
    </strong>
  </div>

  <div class="recipe-time-item">
    ⌛ Total:
    <strong>
      ${
        Number(recipe.prep_time) > 0 ||
        Number(recipe.cook_time) > 0
          ? `${Number(recipe.prep_time || 0) +
              Number(recipe.cook_time || 0)} min`
          : "Not specified"
      }
    </strong>
  </div>

  <div class="recipe-servings">
    🍽 Serves
    ${escapeHtml(
      recipe.servings || "Not specified"
    )}
    ${recipe.servings ? "people" : ""}
  </div>

  <div class="recipe-difficulty-item">
    <strong>Difficulty:</strong>

    <span
      class="difficulty difficulty-${escapeHtml(
        difficulty.toLowerCase()
      )}"
    >
      <span class="difficulty-dot"></span>

      ${escapeHtml(difficulty)}
    </span>
  </div>

</div>

                  <div class="small">
                    <strong>Ingredients:</strong>
                    ${ingredientsHtml}
                  </div>

                </div>
              </div>

              <div class="steps">
                <div class="small">
                  <strong>Steps</strong>
                </div>

                ${stepsHtml}
              </div>
            </article>
          `;
        })
        .join("");

  } catch (error) {
    console.error(error);

    favoritesCount.textContent = "0";

    favoritesResults.innerHTML = `
      <div class="empty">
        ${escapeHtml(
          error.message ||
          "An unexpected error occurred."
        )}
      </div>
    `;
  }
}

// ---------- Remove favorite ----------
if (favoritesResults) {
  favoritesResults.addEventListener(
    "click",
    async (event) => {
      const button =
        event.target.closest(
          ".favorite-btn"
        );

      if (!button) {
        return;
      }

      const recipeId =
        Number(
          button.dataset.recipeId
        ) || 0;

      if (recipeId <= 0) {
        return;
      }

      button.disabled = true;

      try {
        const response = await fetch(
          "toggle_favorite.php",
          {
            method: "POST",

            headers: {
              "Content-Type":
                "application/json"
            },

            body: JSON.stringify({
              recipe_id: recipeId
            })
          }
        );

        const data =
          await response.json();

        if (
          !response.ok ||
          data.success !== true
        ) {
          throw new Error(
            data.message ||
            "Unable to remove favorite."
          );
        }

        if (
          data.is_favorite === false
        ) {
          const recipeCard =
            button.closest(".recipe");

          if (recipeCard) {
            recipeCard.remove();
          }

          const remaining =
            favoritesResults.querySelectorAll(
              ".recipe"
            ).length;

          favoritesCount.textContent =
            String(remaining);

          if (remaining === 0) {
            favoritesResults.innerHTML = `
              <div class="empty">
                You have not saved any favorite recipes yet.
              </div>
            `;
          }
        }
      } catch (error) {
        console.error(error);

        alert(
          error.message ||
          "Unable to remove favorite."
        );

        button.disabled = false;
      }
    }
  );
}

loadFavorites();
