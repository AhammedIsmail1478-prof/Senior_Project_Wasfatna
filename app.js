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

// ---------- Toast notification ----------
function showToast(message, icon = "❤️") {
  const toast =
    document.getElementById("toast");

  const toastMessage =
    document.getElementById("toastMessage");

  const toastIcon =
    document.getElementById("toastIcon");

  if (!toast || !toastMessage || !toastIcon) {
    return;
  }

  toastMessage.textContent = message;
  toastIcon.textContent = icon;

  toast.classList.add("show");

  clearTimeout(showToast.timer);

  showToast.timer = setTimeout(() => {
    toast.classList.remove("show");
  }, 2500);
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

const recipeFilter =
  document.getElementById("recipeFilter");

const randomRecipeBtn =
  document.getElementById("randomRecipeBtn");

// Shopping List elements.
const shoppingListBtn =
  document.getElementById("shoppingListBtn");

const shoppingListCount =
  document.getElementById("shoppingListCount");

const shoppingListPanel =
  document.getElementById("shoppingListPanel");

const shoppingListClose =
  document.getElementById("shoppingListClose");

const shoppingListItems =
  document.getElementById("shoppingListItems");

const clearShoppingListBtn =
  document.getElementById("clearShoppingListBtn");

const printShoppingListBtn =
  document.getElementById("printShoppingListBtn");

const downloadShoppingPdfBtn =
  document.getElementById("downloadShoppingPdfBtn");

const recipeNavigation =
  document.getElementById("recipeNavigation");

const prevRecipeBtn =
  document.getElementById("prevRecipeBtn");

const nextRecipeBtn =
  document.getElementById("nextRecipeBtn");

const recipePageInfo =
  document.getElementById("recipePageInfo");

// Current displayed recipe position.
let currentRecipeIndex = 0;
let currentlyFilteredCards = [];

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
// ---------- Shopping List ----------

const SHOPPING_LIST_KEY =
  "wasfatna-shopping-list";

function loadShoppingList() {
  try {
    const savedItems =
      localStorage.getItem(
        SHOPPING_LIST_KEY
      );

    if (!savedItems) {
      return [];
    }

    const parsedItems =
      JSON.parse(savedItems);

    return Array.isArray(parsedItems)
      ? parsedItems
      : [];
  } catch (error) {
    console.error(
      "Unable to load Shopping List:",
      error
    );

    return [];
  }
}

function saveShoppingList(items) {
  localStorage.setItem(
    SHOPPING_LIST_KEY,
    JSON.stringify(items)
  );

  renderShoppingList();
}

function renderShoppingList() {
  if (!shoppingListItems) {
    return;
  }

  const items = loadShoppingList();

  if (shoppingListCount) {
    shoppingListCount.textContent =
      String(items.length);
  }

  if (clearShoppingListBtn) {
    clearShoppingListBtn.disabled =
      items.length === 0;
  }

  if (printShoppingListBtn) {
  printShoppingListBtn.disabled =
    items.length === 0;
}

if (downloadShoppingPdfBtn) {
  downloadShoppingPdfBtn.disabled =
    items.length === 0;
}

  if (items.length === 0) {
    shoppingListItems.innerHTML = `
      <div class="empty">
        Your shopping list is empty.
      </div>
    `;

    return;
  }

  shoppingListItems.innerHTML =
    items
      .map((item, index) => {
        return `
          <div
            class="shopping-item ${
              item.checked
                ? "shopping-item-completed"
                : ""
            }"
          >
            <label class="shopping-item-label">
              <input
                type="checkbox"
                class="shopping-item-checkbox"
                data-index="${index}"
                ${item.checked ? "checked" : ""}
              >

              <span>
                <strong>
                  ${escapeHtml(item.name)}
                </strong>

                ${
                  item.quantity
                    ? `
                      <span class="shopping-quantity">
                        ${escapeHtml(item.quantity)}
                      </span>
                    `
                    : ""
                }
              </span>
            </label>

            <button
              type="button"
              class="shopping-remove-btn"
              data-index="${index}"
              aria-label="Remove ${escapeHtml(item.name)}"
              title="Remove ingredient"
            >
              ✕
            </button>
          </div>
        `;
      })
      .join("");
}

function addIngredientsToShoppingList(
  ingredients
) {
  if (!Array.isArray(ingredients)) {
    return;
  }

  const items = loadShoppingList();

  const existingNames = new Set(
    items.map((item) =>
      normalizeIngredient(item.name)
    )
  );

  let addedCount = 0;

  ingredients.forEach((ingredient) => {
    const name =
      String(
        ingredient?.name || ""
      ).trim();

    const quantity =
      String(
        ingredient?.quantity || ""
      ).trim();

    if (!name) {
      return;
    }

    const normalizedName =
      normalizeIngredient(name);

    if (existingNames.has(normalizedName)) {
      return;
    }

    items.push({
      name: name,
      quantity: quantity,
      checked: false
    });

    existingNames.add(normalizedName);
    addedCount++;
  });

  saveShoppingList(items);

  if (addedCount > 0) {
    showToast(
      `${addedCount} ingredient${
        addedCount === 1 ? "" : "s"
      } added to Shopping List.`,
      "🛒"
    );
  } else {
    showToast(
      "These ingredients are already in your Shopping List.",
      "ℹ️"
    );
  }
}

function openShoppingList() {
  if (!shoppingListPanel || !backdrop) {
    return;
  }

  // Close the About panel if it is open.
  if (aboutPanel) {
    aboutPanel.classList.remove("open");
    aboutPanel.setAttribute(
      "aria-hidden",
      "true"
    );
  }

  renderShoppingList();

  shoppingListPanel.classList.add("open");

  shoppingListPanel.setAttribute(
    "aria-hidden",
    "false"
  );

  backdrop.hidden = false;
}

function closeShoppingList() {
  if (!shoppingListPanel) {
    return;
  }

  shoppingListPanel.classList.remove("open");

  shoppingListPanel.setAttribute(
    "aria-hidden",
    "true"
  );

  if (backdrop) {
    backdrop.hidden = true;
  }
}

// Open the Shopping List.
if (shoppingListBtn) {
  shoppingListBtn.addEventListener(
    "click",
    openShoppingList
  );
}

// Close the Shopping List.
if (shoppingListClose) {
  shoppingListClose.addEventListener(
    "click",
    closeShoppingList
  );
}

// Clear the complete Shopping List.
if (clearShoppingListBtn) {
  clearShoppingListBtn.addEventListener(
    "click",
    () => {
      localStorage.removeItem(
        SHOPPING_LIST_KEY
      );

      renderShoppingList();

      showToast(
        "Shopping List cleared.",
        "🗑️"
      );
    }
  );
}

// ---------- Print Shopping List ----------
if (printShoppingListBtn) {

  printShoppingListBtn.addEventListener(
    "click",
    () => {

      const items = loadShoppingList();

      if (items.length === 0) {

        showToast(
          "Shopping List is empty.",
          "⚠️"
        );

        return;
      }

      let html = `
        <html>
        <head>
          <title>Shopping List</title>

          <style>

            body{
              font-family:Arial,sans-serif;
              padding:40px;
            }

            h1{
              margin-bottom:20px;
            }

            li{
              margin-bottom:10px;
              font-size:18px;
            }

          </style>

        </head>

        <body>

          <h1>🛒 Shopping List</h1>

          <ul>
      `;

      items.forEach(item => {

        html += `
          <li>

            ${item.name}

            ${item.quantity
              ? `(${item.quantity})`
              : ""}

          </li>
        `;

      });

      html += `
          </ul>
        </body>
        </html>
      `;

      const printWindow =
  window.open(
    "",
    "_blank"
  );

if (!printWindow) {
  showToast(
    "Please allow pop-ups to print the Shopping List.",
    "⚠️"
  );

  return;
}

printWindow.document.write(html);

printWindow.document.close();

printWindow.focus();

printWindow.print();

    }

  );

}

// ---------- Download Shopping List as PDF ----------
if (downloadShoppingPdfBtn) {
  downloadShoppingPdfBtn.addEventListener(
    "click",
    () => {
      const items = loadShoppingList();

      if (items.length === 0) {
        showToast(
          "Shopping List is empty.",
          "⚠️"
        );

        return;
      }

      if (
        !window.jspdf ||
        !window.jspdf.jsPDF
      ) {
        showToast(
          "PDF library could not be loaded.",
          "⚠️"
        );

        return;
      }

      const { jsPDF } = window.jspdf;

      const pdf = new jsPDF({
        orientation: "portrait",
        unit: "mm",
        format: "a4"
      });

      const pageWidth =
        pdf.internal.pageSize.getWidth();

      const pageHeight =
        pdf.internal.pageSize.getHeight();

      const margin = 18;

      let y = 22;

     pdf.setFont("helvetica", "bold");

pdf.setFontSize(24);
pdf.text("🍲 Wasfatna", margin, y);

y += 10;

pdf.setFontSize(18);
pdf.text("Shopping List", margin, y);

y += 8;

pdf.setFont("helvetica", "normal");
pdf.setFontSize(10);

pdf.text(
  `Generated on: ${new Date().toLocaleDateString()}`,
  margin,
  y
);

y += 6;

pdf.setDrawColor(180);
pdf.line(
  margin,
  y,
  pageWidth - margin,
  y
);

y += 8;

      pdf.setFontSize(12);

      items.forEach((item, index) => {
        if (y > pageHeight - 20) {
          pdf.addPage();
          y = 22;
        }

        const status = item.checked ? "☑" : "☐";

        const quantity =
          item.quantity
            ? ` - ${item.quantity}`
            : "";

        const line =
          `${status} ${index + 1}. ` +
          `${item.name}${quantity}`;

        const wrappedLines =
          pdf.splitTextToSize(
            line,
            pageWidth - margin * 2
          );

        pdf.text(
          wrappedLines,
          margin,
          y
        );

        y += wrappedLines.length * 7;
      });

      pdf.setDrawColor(180);

pdf.line(
  margin,
  pageHeight - 15,
  pageWidth - margin,
  pageHeight - 15
);

pdf.setFontSize(9);

pdf.text(
  "Generated by Wasfatna",
  margin,
  pageHeight - 8
);

pdf.text(
  "University of Bahrain - Senior Project",
  pageWidth - margin,
  pageHeight - 8,
  {
    align: "right"
  }
);

      pdf.save(
        "wasfatna-shopping-list.pdf"
      );

      showToast(
        "Shopping List PDF downloaded.",
        "📄"
      );
    }
  );
}


// Mark ingredients as purchased.
if (shoppingListItems) {
  shoppingListItems.addEventListener(
    "change",
    (event) => {
      const checkbox =
        event.target.closest(
          ".shopping-item-checkbox"
        );

      if (!checkbox) {
        return;
      }

      const index =
        Number(checkbox.dataset.index);

      const items =
        loadShoppingList();

      if (!items[index]) {
        return;
      }

      items[index].checked =
        checkbox.checked;

      saveShoppingList(items);
    }
  );

  // Remove one ingredient.
  shoppingListItems.addEventListener(
    "click",
    (event) => {
      const removeBtn =
        event.target.closest(
          ".shopping-remove-btn"
        );

      if (!removeBtn) {
        return;
      }

      const index =
        Number(removeBtn.dataset.index);

      const items =
        loadShoppingList();

      if (!items[index]) {
        return;
      }

      const removedName =
        items[index].name;

      items.splice(index, 1);

      saveShoppingList(items);

      showToast(
        `${removedName} removed.`,
        "🗑️"
      );
    }
  );
}

// Load the saved count when the page opens.
renderShoppingList();

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
  backdrop.addEventListener(
    "click",
    () => {
      closeAbout();
      closeShoppingList();
    }
  );
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

    if (recipeFilter) {
  recipeFilter.value = "all";
}

    resultsEl.innerHTML = `
      <div class="empty">
        No results yet — enter ingredients and click
        “Suggest Recipes”.
      </div>
    `;

    resultsCount.textContent = "0";

    currentRecipeIndex = 0;

    currentlyFilteredCards = [];

if (randomRecipeBtn) {
  randomRecipeBtn.disabled = true;
}

if (recipeNavigation) {
  recipeNavigation.style.display = "none";
}

if (recipePageInfo) {
  recipePageInfo.textContent = "";
}

if (statsRecipes) {
  statsRecipes.textContent = "0";
}

if (statsIngredients) {
  statsIngredients.textContent = "0";
}
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

currentRecipeIndex = 0;

currentlyFilteredCards = [];

if (randomRecipeBtn) {
  randomRecipeBtn.disabled = true;
}

if (recipeNavigation) {
  recipeNavigation.style.display = "none";
}
    
    if (recipeSearch) {
      recipeSearch.value = "";
    }

    if (recipeSort) {
      recipeSort.value = "best-match";
    }

    if (recipeFilter) {
  recipeFilter.value = "all";
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

  currentRecipeIndex = 0;
  currentlyFilteredCards = [];

  if (randomRecipeBtn) {
    randomRecipeBtn.disabled = true;
  }

  if (recipeNavigation) {
    recipeNavigation.style.display = "none";
  }

  if (recipePageInfo) {
    recipePageInfo.textContent = "";
  }

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

          const missingCoreIngredients =
  Array.isArray(recipe.missing_core_ingredients)
    ? recipe.missing_core_ingredients
    : [];

const missingOptionalIngredients =
  Array.isArray(recipe.missing_optional_ingredients)
    ? recipe.missing_optional_ingredients
    : [];

const hasAllCoreIngredients =
  recipe.has_all_core_ingredients === true ||
  Number(recipe.has_all_core_ingredients) === 1;

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

          const encodedMissingIngredients =
  encodeURIComponent(
    JSON.stringify(
      missingIngredients
    )
  );

          const coreIngredientsHtml =
  hasAllCoreIngredients
    ? `
      <div class="small core-success">
        <strong>Core ingredients:</strong>
        All required core ingredients are available ✅
      </div>
    `
    : `
      <div class="small core-warning">
        <strong>Missing core ingredients:</strong>
        ${missingCoreIngredients
          .map(ingredientText)
          .join(", ")}
      </div>
    `;

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
  data-ready-to-cook="${hasAllCoreIngredients}"
  data-is-favorite="${isFavorite}"
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

${coreIngredientsHtml}

<div class="shopping-recipe-action">
  <button
    type="button"
    class="btn btn-outline add-shopping-btn"
    data-shopping-items="${encodedMissingIngredients}"
    ${missingIngredients.length === 0 ? "disabled" : ""}
  >
    ${
      missingIngredients.length === 0
        ? "✅ No Missing Ingredients"
        : "🛒 Add Missing Ingredients"
    }
  </button>
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

      currentlyFilteredCards = [];

if (randomRecipeBtn) {
  randomRecipeBtn.disabled = true;
}

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

        const recipeCard =
  favoriteBtn.closest(".recipe");

if (recipeCard) {
  recipeCard.dataset.isFavorite =
    String(isFavorite);
}

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

        if (isFavorite) {
  showToast(
    "Added to Favorites",
    "❤️"
  );
} else {
  showToast(
    "Removed from Favorites",
    "🤍"
  );
}

if (statsFavorites && resultsEl) {
  statsFavorites.textContent =
    String(
      resultsEl.querySelectorAll(
        '.recipe[data-is-favorite="true"]'
      ).length
    );
}

if (
  recipeFilter &&
  recipeFilter.value === "favorites"
) {
  currentRecipeIndex = 0;
  updateDisplayedRecipes();
}
        
      } catch (error) {
  console.error(error);

  showToast(
    error.message ||
    "Unable to update favorites.",
    "⚠️"
  );
} finally {
        favoriteBtn.disabled = false;
      }
    }
  );
}

// ---------- Add missing ingredients to Shopping List ----------
if (resultsEl) {
  resultsEl.addEventListener(
    "click",
    (event) => {
      const addShoppingBtn =
        event.target.closest(
          ".add-shopping-btn"
        );

      if (!addShoppingBtn) {
        return;
      }

      try {
        const encodedItems =
          addShoppingBtn.dataset
            .shoppingItems || "";

        const missingItems =
          JSON.parse(
            decodeURIComponent(
              encodedItems
            )
          );

        addIngredientsToShoppingList(
          missingItems
        );
      } catch (error) {
        console.error(
          "Unable to add Shopping List ingredients:",
          error
        );

        showToast(
          "Unable to add ingredients.",
          "⚠️"
        );
      }
    }
  );
}

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

  const filterValue = recipeFilter
  ? recipeFilter.value
  : "all";

  // Remove the previous no-results message.
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

  // Sort the recipe cards.
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

    // Best Match.
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

  // Reinsert the cards in the selected order.
  recipeCards.forEach((card) => {
    resultsEl.appendChild(card);
  });

  // Find recipes that match both the search box
// and the selected recipe filter.
const filteredCards =
  recipeCards.filter((card) => {
    const filterText =
      card.dataset.filterText || "";

    const matchPercentage =
      Number(card.dataset.matchPercentage) || 0;

    const isReadyToCook =
      card.dataset.readyToCook === "true";

    const isFavorite =
      card.dataset.isFavorite === "true";

    // First apply the search box.
    const matchesSearch =
      filterText.includes(searchValue);

    if (!matchesSearch) {
      return false;
    }

    // Then apply the new filter dropdown.
    if (filterValue === "perfect") {
      return matchPercentage === 100;
    }

    if (filterValue === "excellent") {
      return (
        matchPercentage >= 90 &&
        matchPercentage < 100
      );
    }

    if (filterValue === "good") {
      return (
        matchPercentage >= 75 &&
        matchPercentage < 90
      );
    }

    if (filterValue === "partial") {
      return (
        matchPercentage >= 50 &&
        matchPercentage < 75
      );
    }

    if (filterValue === "low") {
      return matchPercentage < 50;
    }

    if (filterValue === "ready") {
      return isReadyToCook;
    }

    if (filterValue === "missing-core") {
      return !isReadyToCook;
    }

    if (filterValue === "favorites") {
      return isFavorite;
    }

    // "All Recipes"
    return true;
  });

  // Hide every card first.
  recipeCards.forEach((card) => {
    card.hidden = true;
  });
currentlyFilteredCards = filteredCards;
  const visibleCount = filteredCards.length;

  if (randomRecipeBtn) {
  randomRecipeBtn.disabled =
    visibleCount === 0;
}

  resultsCount.textContent =
    String(visibleCount);

  // No matching recipes.
  if (visibleCount === 0) {
    currentRecipeIndex = 0;

    if (recipeNavigation) {
      recipeNavigation.style.display = "none";
    }

    if (recipePageInfo) {
      recipePageInfo.textContent = "";
    }

    if (recipeCards.length > 0) {
      resultsEl.insertAdjacentHTML(
        "beforeend",
        `
          <div class="empty filter-empty-message">
  No recipes match the selected search or filter.
</div>
        `
      );
    }

    return;
  }

  // Prevent the index from going outside the array.
  if (currentRecipeIndex >= visibleCount) {
    currentRecipeIndex = visibleCount - 1;
  }

  if (currentRecipeIndex < 0) {
    currentRecipeIndex = 0;
  }

  // Display only the selected recipe.
  filteredCards[currentRecipeIndex].hidden =
    false;

  // Show the navigation.
  if (recipeNavigation) {
    recipeNavigation.style.display =
      visibleCount > 1 ? "flex" : "none";
  }

  // Show dynamic page information.
  if (recipePageInfo) {
    recipePageInfo.textContent =
      `${currentRecipeIndex + 1} of ${visibleCount}`;
  }

  // Disable Previous on the first recipe.
  if (prevRecipeBtn) {
    prevRecipeBtn.disabled =
      currentRecipeIndex === 0;
  }

  // Disable Next on the final recipe.
  if (nextRecipeBtn) {
    nextRecipeBtn.disabled =
      currentRecipeIndex === visibleCount - 1;
  }
}

if (recipeSearch) {
  recipeSearch.addEventListener(
    "input",
    () => {
      currentRecipeIndex = 0;
      updateDisplayedRecipes();
    }
  );
}

if (recipeSort) {
  recipeSort.addEventListener(
    "change",
    () => {
      currentRecipeIndex = 0;
      updateDisplayedRecipes();
    }
  );
}

if (recipeFilter) {
  recipeFilter.addEventListener(
    "change",
    () => {
      currentRecipeIndex = 0;
      updateDisplayedRecipes();
    }
  );
}

if (randomRecipeBtn) {
  randomRecipeBtn.addEventListener(
    "click",
    () => {
      const recipeCount =
        currentlyFilteredCards.length;

      if (recipeCount === 0) {
        showToast(
          "Search for recipes first.",
          "⚠️"
        );

        return;
      }

      let randomIndex =
        Math.floor(
          Math.random() * recipeCount
        );

      if (
        recipeCount > 1 &&
        randomIndex === currentRecipeIndex
      ) {
        randomIndex =
          (randomIndex + 1) % recipeCount;
      }

      currentRecipeIndex = randomIndex;

      updateDisplayedRecipes();

      const selectedCard =
        currentlyFilteredCards[
          currentRecipeIndex
        ];

      const selectedName =
        selectedCard?.dataset.recipeName ||
        "a random recipe";

      showToast(
        `Surprise! Try ${selectedName}.`,
        "🎲"
      );
    }
  );
}

if (prevRecipeBtn) {
  prevRecipeBtn.addEventListener(
    "click",
    () => {
      if (currentRecipeIndex > 0) {
        currentRecipeIndex--;
        updateDisplayedRecipes();
      }
    }
  );
}

if (nextRecipeBtn) {
  nextRecipeBtn.addEventListener(
    "click",
    () => {
      if (!nextRecipeBtn.disabled) {
        currentRecipeIndex++;
        updateDisplayedRecipes();
      }
    }
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
