// ---------- Theme toggle ----------
const themeToggleBtn = document.getElementById("themeToggle");

function applyTheme(theme) {
  document.documentElement.setAttribute("data-theme", theme);

  if (themeToggleBtn) {
    themeToggleBtn.textContent =
      theme === "light" ? "☀️ Light" : "🌙 Dark";
  }
}

// Sync the button label with the current theme.
const currentTheme =
  document.documentElement.getAttribute("data-theme") || "dark";

applyTheme(currentTheme);

if (themeToggleBtn) {
  themeToggleBtn.addEventListener("click", () => {
    const current =
      document.documentElement.getAttribute("data-theme");

    const next = current === "light" ? "dark" : "light";

    localStorage.setItem("wasfatna-theme", next);
    applyTheme(next);
  });
}

// ---------- General helpers ----------
function normalizeIngredient(value) {
  return String(value).trim().toLowerCase();
}

function parseIngredients(text) {
  return String(text)
    .split(",")
    .map(normalizeIngredient)
    .filter(Boolean);
}

function uniq(items) {
  return [...new Set(items)];
}

// Prevent HTML code from being inserted into the page.
function escapeHtml(value) {
  return String(value ?? "")
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}

// Display the ingredient name together with its quantity.
function ingredientText(item) {
  if (!item) {
    return "";
  }

  const name = escapeHtml(item.name ?? "");

  const quantity = item.quantity
    ? ` — ${escapeHtml(item.quantity)}`
    : "";

  return `${name}${quantity}`;
}

// ---------- DOM elements ----------

function updateRecipeSuggestions(recipes) {
  if (!recipeSuggestions) {
    return;
  }

  const recipeNames = [
    ...new Set(
      recipes
        .map((recipe) => {
          return (
            recipe.recipe_name ??
            recipe.name ??
            ""
          );
        })
        .filter(Boolean)
    )
  ];

  recipeSuggestions.innerHTML =
    recipeNames
      .sort((firstName, secondName) =>
        firstName.localeCompare(secondName)
      )
      .map(
        (name) =>
          `<option value="${escapeHtml(name)}"></option>`
      )
      .join("");
}

const ingredientsInput =
  document.getElementById("ingredientsInput");

const suggestBtn =
  document.getElementById("suggestBtn");

const clearBtn =
  document.getElementById("clearBtn");

const resultsEl =
  document.getElementById("results");

const resultsCount =
  document.getElementById("resultsCount");

const statsRecipes =
  document.getElementById("statsRecipes");

const statsFavorites =
  document.getElementById("statsFavorites");

const statsIngredients =
  document.getElementById("statsIngredients");

const recipeSearch =
  document.getElementById("recipeSearch");

const recipeSuggestions =
  document.getElementById("recipeSuggestions");

const recipeSort =
  document.getElementById("recipeSort");

// Preference fields.
const spiceEl =
  document.getElementById("spice");

const sweetnessEl =
  document.getElementById("sweetness");

const goalEl =
  document.getElementById("goal");

const dietEl =
  document.getElementById("diet");

// About panel elements.
const aboutBtn =
  document.getElementById("aboutBtn");

const aboutPanel =
  document.getElementById("aboutPanel");

const aboutClose =
  document.getElementById("aboutClose");

const backdrop =
  document.getElementById("backdrop");

// ---------- About panel ----------
function openAbout() {
  if (!aboutPanel || !backdrop) {
    return;
  }

  aboutPanel.classList.add("open");
  aboutPanel.setAttribute("aria-hidden", "false");
  backdrop.hidden = false;
}

function closeAbout() {
  if (!aboutPanel || !backdrop) {
    return;
  }

  aboutPanel.classList.remove("open");
  aboutPanel.setAttribute("aria-hidden", "true");
  backdrop.hidden = true;
}

if (aboutBtn) {
  aboutBtn.addEventListener("click", openAbout);
}

if (aboutClose) {
  aboutClose.addEventListener("click", closeAbout);
}

if (backdrop) {
  backdrop.addEventListener("click", closeAbout);
}

// ---------- Clear button ----------
if (
  clearBtn &&
  ingredientsInput &&
  resultsEl &&
  resultsCount
) {
  clearBtn.addEventListener("click", () => {
    ingredientsInput.value = "";

    if (recipeSearch) {
      recipeSearch.value = "";
    }

if (recipeSuggestions) {
  recipeSuggestions.innerHTML = "";
}
    
    if (recipeSort) {
      recipeSort.value = "best-match";
    }

    resultsEl.innerHTML = `
      <div class="empty">
        No results yet — enter ingredients and click
        “Suggest Recipes”.
      </div>
    `;

    resultsCount.textContent = "0";
  });
}

// ---------- Recipe database search ----------
if (
  suggestBtn &&
  ingredientsInput &&
  resultsEl &&
  resultsCount
) {
  suggestBtn.addEventListener("click", async () => {
    if (recipeSearch) {
      recipeSearch.value = "";
    }

    if (recipeSort) {
      recipeSort.value = "best-match";
    }

    const ingredients = uniq(
      parseIngredients(ingredientsInput.value)
    );

    const spice =
      spiceEl ? spiceEl.value : "any";

    const sweetness =
      sweetnessEl ? sweetnessEl.value : "any";

    const goal =
      goalEl ? goalEl.value : "any";

    const diet =
      dietEl ? dietEl.value : "none";

    if (!ingredients.length) {
      resultsEl.innerHTML = `
        <div class="empty">
          Please enter at least one ingredient.
          Separate ingredients using commas.
        </div>
      `;

      resultsCount.textContent = "0";
      return;
    }

    suggestBtn.disabled = true;
    suggestBtn.textContent = "Searching...";

    resultsEl.innerHTML = `
      <div class="empty">
        Searching the Wasfatna database...
      </div>
    `;

    try {
      const response = await fetch("search_recipes.php", {
        method: "POST",

        headers: {
          "Content-Type": "application/json"
        },

        body: JSON.stringify({
          ingredients: ingredients,
          spice: spice,
          sweetness: sweetness,
          goal: goal,
          diet: diet
        })
      });

      /*
       * Read the response as text first.
       * This helps show a clear error when PHP returns
       * an HTML warning instead of valid JSON.
       */
      const responseText = await response.text();

      let data;

      try {
        data = JSON.parse(responseText);
      } catch (jsonError) {
        console.error(
          "Invalid PHP response:",
          responseText
        );

        throw new Error(
          "search_recipes.php did not return valid JSON. " +
          "Check the PHP file for an error."
        );
      }

      if (!response.ok || data.success !== true) {
        throw new Error(
          data.message || "Recipe search failed."
        );
      }

      const recipes = Array.isArray(data.recipes)
        ? data.recipes
        : [];

      updateRecipeSuggestions(recipes);

      resultsCount.textContent =
        String(recipes.length);

if (statsRecipes) {
  statsRecipes.textContent = recipes.length;
}

if (statsIngredients) {
  statsIngredients.textContent = ingredients.length;
}

if (statsFavorites) {
  statsFavorites.textContent =
    recipes.filter(recipe => recipe.is_favorite).length;
}
      

      if (!recipes.length) {
        resultsEl.innerHTML = `
          <div class="empty">
            No matching recipes were found.
            Check the ingredient spelling and separate
            ingredients using commas.
          </div>
        `;

        return;
      }

      resultsEl.innerHTML = recipes
        .map((recipe) => {
          const matchedIngredients =
            Array.isArray(recipe.matched_ingredients)
              ? recipe.matched_ingredients
              : [];

          const missingIngredients =
            Array.isArray(recipe.missing_ingredients)
              ? recipe.missing_ingredients
              : [];

          const steps =
            Array.isArray(recipe.steps)
              ? recipe.steps
              : [];

          const matchedHtml =
            matchedIngredients.length
              ? matchedIngredients
                  .map(ingredientText)
                  .join(", ")
              : "None";

          const missingHtml =
            missingIngredients.length
              ? missingIngredients
                  .map(ingredientText)
                  .join(", ")
              : "None — you have all ingredients ✅";

          const stepsHtml =
            steps.length
              ? `
                <ol>
                  ${steps
                    .map(
                      (step) =>
                        `<li>${escapeHtml(step)}</li>`
                    )
                    .join("")}
                    
                </ol>
              `
              : `
                <div class="small">
                  No steps are stored for this recipe.
                </div>
              `;

          const recipeName =
            recipe.recipe_name ??
            recipe.name ??
            "Recipe";

    const recipeId =
      Number(recipe.recipe_id) || 0;

    const isFavorite =
      recipe.is_favorite === true ||
      Number(recipe.is_favorite) === 1;
          
            const imageFile =
    String(recipe.image || "").trim();

    const imagePath =
    imageFile !== ""
      ? `images/${encodeURIComponent(imageFile)}`
      : "images/default_recipe.png";

          const matchPercentage =
            Number(recipe.match_percentage) || 0;

          const matchedCount =
            Number(recipe.matched_count) || 0;

          const totalIngredients =
            Number(recipe.total_ingredients) || 0;

const searchableIngredients = [
  ...matchedIngredients,
  ...missingIngredients
]
  .map((ingredient) =>
    String(ingredient.name || "").trim()
  )
  .join(" ");

const filterText = [
  recipeName,
  searchableIngredients
]
  .join(" ")
  .toLowerCase();
          
         const matchClass =
  matchPercentage === 100
    ? "match-perfect"
    : matchPercentage >= 75
    ? "match-excellent"
    : matchPercentage >= 50
    ? "match-good"
    : "match-partial";

          return `

<article
  class="recipe"
  data-recipe-name="${escapeHtml(recipeName.toLowerCase())}"
  data-filter-text="${escapeHtml(filterText)}"
  data-match-percentage="${matchPercentage}"
  data-matched-count="${matchedCount}"
>
 
    <div class="recipe-summary">

      <img
        src="${imagePath}"
        alt="${escapeHtml(recipeName)}"
        class="recipe-image"
        loading="lazy"
        onerror="this.onerror=null; this.src='images/default_recipe.png';"
      >

      <div class="recipe-information">

        <div class="recipe-top">

  <div class="recipe-title-row">
    <h4>
      ${escapeHtml(recipeName)}
    </h4>

    <button
      type="button"
      class="favorite-btn ${
        isFavorite ? "is-favorite" : ""
      }"
      data-recipe-id="${recipeId}"
      aria-pressed="${isFavorite}"
      aria-label="${
        isFavorite
          ? "Remove from favorites"
          : "Add to favorites"
      }"
      title="${
        isFavorite
          ? "Remove from favorites"
          : "Add to favorites"
      }"
    >
      ${isFavorite ? "❤️" : "🤍"}
    </button>
  </div>

  <div class="tags">
            <span class="tag ${matchClass}">
              ${matchPercentage}% match
            </span>

            <span class="tag">
              ${matchedCount}/${totalIngredients} ingredients
            </span>
          </div>
        </div>

        <div class="small">
          <strong>You have:</strong>
          ${matchedHtml}
        </div>

        <div class="small">
          <strong>Still needed:</strong>
          ${missingHtml}
        </div>

        <div class="recipe-details">
  <div class="small">
    <strong>Serves:</strong>
    ${escapeHtml(recipe.servings || "Not specified")}
  </div>

  <div class="small">
    <strong>Difficulty:</strong>

    <span class="difficulty difficulty-${String(
      recipe.difficulty || ""
    ).toLowerCase()}">
      <span class="difficulty-dot"></span>

      ${escapeHtml(
        recipe.difficulty || "Unknown"
      )}
    </span>
  </div>
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
      updateDisplayedRecipes();
    } catch (error) {
      console.error(error);

      resultsCount.textContent = "0";

      if (statsRecipes) {
  statsRecipes.textContent = "0";
}

if (statsFavorites) {
  statsFavorites.textContent = "0";
}

if (statsIngredients) {
  statsIngredients.textContent = "0";
}

      resultsEl.innerHTML = `
        <div class="empty">
          ${escapeHtml(
            error.message ||
            "An unexpected error occurred."
          )}
        </div>
      `;
    } finally {
      suggestBtn.disabled = false;
      suggestBtn.textContent = "Suggest Recipes";
    }
  });
}

// ---------- Favorite recipe button ----------
if (resultsEl) {
  resultsEl.addEventListener(
    "click",
    async (event) => {
      const favoriteBtn =
        event.target.closest(".favorite-btn");

      if (
        !favoriteBtn ||
        !resultsEl.contains(favoriteBtn)
      ) {
        return;
      }

      const recipeId =
        Number(
          favoriteBtn.dataset.recipeId
        ) || 0;

      if (recipeId <= 0) {
        return;
      }

      favoriteBtn.disabled = true;

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

        const responseText =
          await response.text();

        let data;

        try {
          data = JSON.parse(responseText);
        } catch (jsonError) {
          console.error(
            "Invalid favorite response:",
            responseText
          );

          throw new Error(
            "toggle_favorite.php did not return valid JSON."
          );
        }

        if (
          !response.ok ||
          data.success !== true
        ) {
          throw new Error(
            data.message ||
            "Unable to update favorites."
          );
        }

        const isFavorite =
          data.is_favorite === true;

        favoriteBtn.textContent =
          isFavorite ? "❤️" : "🤍";

        favoriteBtn.classList.toggle(
          "is-favorite",
          isFavorite
        );

        favoriteBtn.setAttribute(
          "aria-pressed",
          String(isFavorite)
        );

        const buttonText = isFavorite
          ? "Remove from favorites"
          : "Add to favorites";

        favoriteBtn.setAttribute(
          "aria-label",
          buttonText
        );

        favoriteBtn.title = buttonText;
      } catch (error) {
        console.error(error);

        alert(
          error.message ||
          "Unable to update favorites."
        );
      } finally {
        favoriteBtn.disabled = false;
      }
    }
  );
}

// ---------- Filter and sort displayed recipes ----------
function updateDisplayedRecipes() {
  if (!resultsEl || !resultsCount) {
    return;
  }

  const searchValue = recipeSearch
    ? recipeSearch.value.trim().toLowerCase()
    : "";

  const sortValue = recipeSort
    ? recipeSort.value
    : "best-match";

  const oldMessage =
    resultsEl.querySelector(
      ".filter-empty-message"
    );

  if (oldMessage) {
    oldMessage.remove();
  }

  const recipeCards = Array.from(
    resultsEl.querySelectorAll(".recipe")
  );

  recipeCards.sort((firstCard, secondCard) => {
    const firstName =
      firstCard.dataset.recipeName || "";

    const secondName =
      secondCard.dataset.recipeName || "";

    const firstPercentage =
      Number(
        firstCard.dataset.matchPercentage
      ) || 0;

    const secondPercentage =
      Number(
        secondCard.dataset.matchPercentage
      ) || 0;

    const firstMatched =
      Number(
        firstCard.dataset.matchedCount
      ) || 0;

    const secondMatched =
      Number(
        secondCard.dataset.matchedCount
      ) || 0;

    if (sortValue === "name-asc") {
      return firstName.localeCompare(
        secondName
      );
    }

    if (sortValue === "name-desc") {
      return secondName.localeCompare(
        firstName
      );
    }

    if (sortValue === "most-matched") {
      if (firstMatched !== secondMatched) {
        return secondMatched - firstMatched;
      }

      return (
        secondPercentage -
        firstPercentage
      );
    }

    if (sortValue === "lowest-match") {
      if (
        firstPercentage !==
        secondPercentage
      ) {
        return (
          firstPercentage -
          secondPercentage
        );
      }

      return firstName.localeCompare(
        secondName
      );
    }

    // Best Match
    if (
      firstPercentage !==
      secondPercentage
    ) {
      return (
        secondPercentage -
        firstPercentage
      );
    }

    if (firstMatched !== secondMatched) {
      return secondMatched - firstMatched;
    }

    return firstName.localeCompare(
      secondName
    );
  });

  let visibleCount = 0;

  recipeCards.forEach((card) => {
    const filterText =
      card.dataset.filterText || "";

    const shouldShow =
      filterText.includes(searchValue);

    card.hidden = !shouldShow;

    if (shouldShow) {
      visibleCount++;
    }

    // Reinsert cards in the selected order.
    resultsEl.appendChild(card);
  });

  resultsCount.textContent =
    String(visibleCount);

  if (
    recipeCards.length > 0 &&
    visibleCount === 0
  ) {
    resultsEl.insertAdjacentHTML(
      "beforeend",
      `
        <div class="empty filter-empty-message">
          No recipe or ingredient matches your search.
        </div>
      `
    );
  }
}

if (recipeSearch) {
  recipeSearch.addEventListener(
    "input",
    updateDisplayedRecipes
  );
}

if (recipeSort) {
  recipeSort.addEventListener(
    "change",
    updateDisplayedRecipes
  );
}

// Allow the Enter key to start the recipe search.
if (ingredientsInput && suggestBtn) {
  ingredientsInput.addEventListener(
    "keydown",
    (event) => {
      if (
        event.key === "Enter" &&
        !event.shiftKey
      ) {
        event.preventDefault();
        suggestBtn.click();
      }
    }
  );
}

// ---------- Sign-out confirmation ----------
const signOutLinks = Array.from(
  document.querySelectorAll(
    'a[href="signout.php"]'
  )
);

let logoutOverlayEl = null;
let previousBodyOverflow = "";
let onLogoutKeydown = null;

function closeLogoutConfirm() {
  if (!logoutOverlayEl) {
    return;
  }

  if (onLogoutKeydown) {
    document.removeEventListener(
      "keydown",
      onLogoutKeydown
    );

    onLogoutKeydown = null;
  }

  logoutOverlayEl.remove();
  logoutOverlayEl = null;

  document.body.style.overflow =
    previousBodyOverflow;
}

function openLogoutConfirm(targetHref) {
  if (logoutOverlayEl) {
    return;
  }

  previousBodyOverflow =
    document.body.style.overflow;

  document.body.style.overflow = "hidden";

  logoutOverlayEl =
    document.createElement("div");

  logoutOverlayEl.className =
    "logout-overlay";

  logoutOverlayEl.setAttribute(
    "role",
    "dialog"
  );

  logoutOverlayEl.setAttribute(
    "aria-modal",
    "true"
  );

  logoutOverlayEl.setAttribute(
    "aria-labelledby",
    "logoutTitle"
  );

  logoutOverlayEl.innerHTML = `
    <div class="logout-dialog">
      <h3
        id="logoutTitle"
        class="logout-title"
      >
        You are about to log out
      </h3>

      <p class="logout-text">
        Are you sure you want to continue?
      </p>

      <div class="logout-actions">
        <button
          type="button"
          class="btn btn-outline"
          data-action="cancel"
        >
          Cancel
        </button>

        <button
          type="button"
          class="btn btn-danger"
          data-action="confirm"
        >
          Confirm
        </button>
      </div>
    </div>
  `;

  document.body.appendChild(
    logoutOverlayEl
  );

  const cancelBtn =
    logoutOverlayEl.querySelector(
      '[data-action="cancel"]'
    );

  const confirmBtn =
    logoutOverlayEl.querySelector(
      '[data-action="confirm"]'
    );

  if (cancelBtn) {
    cancelBtn.addEventListener(
      "click",
      closeLogoutConfirm
    );
  }

  if (confirmBtn) {
    confirmBtn.addEventListener(
      "click",
      () => {
        window.location.href =
          targetHref;
      }
    );
  }

  logoutOverlayEl.addEventListener(
    "click",
    (event) => {
      if (event.target === logoutOverlayEl) {
        closeLogoutConfirm();
      }
    }
  );

  onLogoutKeydown = (event) => {
    if (event.key === "Escape") {
      closeLogoutConfirm();
    }
  };

  document.addEventListener(
    "keydown",
    onLogoutKeydown
  );

  if (cancelBtn) {
    cancelBtn.focus();
  }
}

if (signOutLinks.length) {
  signOutLinks.forEach((link) => {
    link.addEventListener(
      "click",
      (event) => {
        event.preventDefault();

        openLogoutConfirm(
          link.getAttribute("href") ||
          "signout.php"
        );
      }
    );
  });
}
