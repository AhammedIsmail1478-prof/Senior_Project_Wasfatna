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

// ---------- Perfect Match Celebration ----------

function celebratePerfectMatch() {
  if (typeof confetti !== "function") {
    return;
  }

  confetti({
    particleCount: 100,
    spread: 75,
    origin: {
      y: 0.6
    }
  });

  setTimeout(() => {
    confetti({
      particleCount: 70,
      spread: 100,
      origin: {
        y: 0.6
      }
    });
  }, 450);
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

const voiceSearchBtn =
  document.getElementById("voiceSearchBtn");

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

const smartSearchSummary =
  document.getElementById("smartSearchSummary");

const summaryIngredients =
  document.getElementById("summaryIngredients");

const summaryRecipeCount =
  document.getElementById("summaryRecipeCount");

const summarySpice =
  document.getElementById("summarySpice");

const summaryGoal =
  document.getElementById("summaryGoal");

const summaryDiet =
  document.getElementById("summaryDiet");

const smartIngredientSuggestions =
  document.getElementById("smartIngredientSuggestions");

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

// Recently Viewed elements.
const recentlyViewedSection =
  document.getElementById(
    "recentlyViewedSection"
  );

const recentlyViewedList =
  document.getElementById(
    "recentlyViewedList"
  );

const clearRecentlyViewedBtn =
  document.getElementById(
    "clearRecentlyViewedBtn"
  );

let currentRecipeIndex = 0;
let currentlyFilteredCards = [];

// Recipe opened from Recipe of the Day.
let requestedRecipeId =
  Number(window.initialRecipeId) || 0;

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

// ---------- Voice Ingredient Search ----------

const SpeechRecognition =
  window.SpeechRecognition ||
  window.webkitSpeechRecognition;

let ingredientRecognition = null;
let isVoiceListening = false;

function setVoiceButtonState(isListening) {
  if (!voiceSearchBtn) {
    return;
  }

  isVoiceListening = isListening;

  voiceSearchBtn.classList.toggle(
    "is-listening",
    isListening
  );

  voiceSearchBtn.textContent =
    isListening
      ? "🎙 Listening..."
      : "🎤 Speak Ingredients";

  voiceSearchBtn.setAttribute(
    "aria-pressed",
    String(isListening)
  );
}

if (
  voiceSearchBtn &&
  ingredientsInput
) {
  if (!SpeechRecognition) {
    voiceSearchBtn.disabled = true;
    voiceSearchBtn.textContent =
      "🎤 Voice Not Supported";

    voiceSearchBtn.title =
      "Voice recognition is not supported by this browser.";
  } else {
    ingredientRecognition =
      new SpeechRecognition();

    ingredientRecognition.lang =
      "en-US";

    ingredientRecognition.continuous =
      false;

    ingredientRecognition.interimResults =
      false;

    ingredientRecognition.maxAlternatives =
      1;

    voiceSearchBtn.addEventListener(
      "click",
      () => {
        if (isVoiceListening) {
          ingredientRecognition.stop();
          return;
        }

        try {
          ingredientRecognition.start();
        } catch (error) {
          console.error(
            "Unable to start voice search:",
            error
          );

          showToast(
            "Voice search is already running.",
            "⚠️"
          );
        }
      }
    );

    ingredientRecognition.addEventListener(
      "start",
      () => {
        setVoiceButtonState(true);

        showToast(
          "Speak your ingredients now.",
          "🎤"
        );
      }
    );

    ingredientRecognition.addEventListener(
      "result",
      (event) => {
        const transcript =
          event.results?.[0]?.[0]
            ?.transcript || "";

        const spokenIngredients =
          transcript
            .replace(/\band\b/gi, ",")
            .replace(/[.،]/g, ",")
            .split(",")
            .map((ingredient) =>
              ingredient.trim()
            )
            .filter(Boolean);

        if (
          spokenIngredients.length === 0
        ) {
          showToast(
            "No ingredients were recognized.",
            "⚠️"
          );

          return;
        }

        const existingIngredients =
          parseIngredients(
            ingredientsInput.value
          );

        const combinedIngredients =
          uniq([
            ...existingIngredients,
            ...spokenIngredients.map(
              normalizeIngredient
            )
          ]);

        ingredientsInput.value =
          combinedIngredients.join(", ");

        if (statsIngredients) {
          statsIngredients.textContent =
            String(
              combinedIngredients.length
            );
        }

        showToast(
          `${spokenIngredients.length} ingredient${
            spokenIngredients.length === 1
              ? ""
              : "s"
          } recognized.`,
          "✅"
        );
      }
    );

    ingredientRecognition.addEventListener(
      "error",
      (event) => {
        console.error(
          "Voice recognition error:",
          event.error
        );

        let message =
          "Unable to recognize your voice.";

        if (
          event.error === "not-allowed" ||
          event.error ===
            "service-not-allowed"
        ) {
          message =
            "Please allow microphone access.";
        } else if (
          event.error === "no-speech"
        ) {
          message =
            "No speech was detected. Please try again.";
        } else if (
          event.error === "audio-capture"
        ) {
          message =
            "No microphone was detected.";
        } else if (
          event.error === "network"
        ) {
          message =
            "Voice recognition network error.";
        }

        showToast(message, "⚠️");
      }
    );

    ingredientRecognition.addEventListener(
      "end",
      () => {
        setVoiceButtonState(false);
      }
    );
  }
}

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
  ingredients,
  recipeName
) {
  if (!Array.isArray(ingredients)) {
    return;
  }

  const items = loadShoppingList();

  const existingItems = new Set(
    items.map((item) =>
      `${normalizeIngredient(
        item.recipeName || ""
      )}|${normalizeIngredient(item.name)}`
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

    const itemKey =
      `${normalizeIngredient(
        recipeName || "Recipe"
      )}|${normalizedName}`;

    if (existingItems.has(itemKey)) {
      return;
    }

    items.push({
      name: name,
      quantity: quantity,
      recipeName: recipeName || "Recipe",
      checked: false
    });

    existingItems.add(itemKey);

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
pdf.text("Wasfatna", margin, y);

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

      // Group items by recipe name.
const groupedItems = {};

items.forEach((item) => {
  const recipeName =
    item.recipeName || "Other Ingredients";

  if (!groupedItems[recipeName]) {
    groupedItems[recipeName] = [];
  }

  groupedItems[recipeName].push(item);
});

Object.entries(groupedItems).forEach(
  ([recipeName, recipeItems]) => {

    if (y > pageHeight - 35) {
      pdf.addPage();
      y = 22;
    }

    // Recipe name.
    pdf.setFont("helvetica", "bold");
    pdf.setFontSize(15);

    pdf.text(
      recipeName,
      margin,
      y
    );

    y += 8;

    // Missing ingredients.
    pdf.setFont("helvetica", "normal");
    pdf.setFontSize(12);

    recipeItems.forEach(
      (item, index) => {

        if (y > pageHeight - 20) {
          pdf.addPage();
          y = 22;
        }

        const status =
          item.checked ? "✓" : "-";

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
      }
    );

    y += 6;
  }
);

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

    if (
  !ingredients.length &&
  requestedRecipeId <= 0
) {
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
  diet: diet,
  recipe_id: requestedRecipeId
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

if (smartSearchSummary) {
  smartSearchSummary.hidden = false;
}

if (summaryIngredients) {

  if (ingredients.length) {

    summaryIngredients.innerHTML =
      ingredients
        .map((ingredient) => `
          <span class="current-ingredient-chip">
            ${escapeHtml(ingredient)}
          </span>
        `)
        .join("");

  } else {

    summaryIngredients.textContent = "None";

  }
}

if (summaryRecipeCount) {
  summaryRecipeCount.textContent =
    String(recipes.length);
}

if (summarySpice) {
  summarySpice.textContent =
    spice === "any"
      ? "Any"
      : spice.charAt(0).toUpperCase() +
        spice.slice(1);
}

if (summaryGoal) {
  summaryGoal.textContent =
    goal === "any"
      ? "Any"
      : goal
          .replaceAll("-", " ")
          .replace(/\b\w/g, (letter) =>
            letter.toUpperCase()
          );
}

if (summaryDiet) {
  summaryDiet.textContent =
    diet === "none"
      ? "None"
      : diet
          .replaceAll("-", " ")
          .replace(/\b\w/g, (letter) =>
            letter.toUpperCase()
          );
}

      // ---------- Smart Ingredient Suggestions ----------

if (smartIngredientSuggestions) {

  const missingCounts = {};

  recipes.forEach((recipe) => {

  const missing =
    Array.isArray(recipe.missing_ingredients)
      ? recipe.missing_ingredients
      : [];

  const uniqueMissingNames =
    new Set(
      missing
        .map((item) =>
          String(item?.name || "")
            .trim()
            .toLowerCase()
        )
        .filter(Boolean)
    );

  uniqueMissingNames.forEach((name) => {

    if (ingredients.includes(name)) {
      return;
    }

    missingCounts[name] =
      (missingCounts[name] || 0) + 1;
  });
});

  const suggestedIngredients =
  Object.entries(missingCounts)
    .sort((first, second) =>
      second[1] - first[1]
    )
    .slice(0, 5)
    .map(([name, count]) => ({
      name,
      count
    }));

  if (suggestedIngredients.length === 0) {

    smartIngredientSuggestions.innerHTML = `
      <span class="smart-no-suggestions">
        Great! No additional ingredient suggestions are needed.
      </span>
    `;

  } else {

    smartIngredientSuggestions.innerHTML =
  suggestedIngredients
    .map(({ name, count }) => `
      <button
        type="button"
        class="smart-ingredient-btn"
        data-ingredient="${escapeHtml(name)}"
        title="Needed by ${count} matching recipes"
      >
        <span class="smart-ingredient-name">
          + ${escapeHtml(name)}
        </span>

        <span class="smart-ingredient-count">
          ${count} recipe${count === 1 ? "" : "s"}
        </span>
      </button>
    `)
    .join("");
  }
}

      // ---------- Add Smart Suggested Ingredient ----------

if (smartIngredientSuggestions) {
  smartIngredientSuggestions.addEventListener(
    "click",
    (event) => {

      const ingredientBtn =
        event.target.closest(
          ".smart-ingredient-btn"
        );

      if (!ingredientBtn) {
        return;
      }

      const ingredient =
        ingredientBtn.dataset.ingredient;

      if (!ingredient) {
        return;
      }

      const currentIngredients =
        uniq(
          parseIngredients(
            ingredientsInput.value
          )
        );

      if (
        !currentIngredients.includes(
          ingredient
        )
      ) {
        currentIngredients.push(
          ingredient
        );
      }

      ingredientsInput.value =
        currentIngredients.join(", ");

      showToast(
        `${ingredient} added to your ingredients.`,
        "➕"
      );
    }
  );
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

          const encodedAllIngredients =
  encodeURIComponent(
    JSON.stringify([
      ...matchedIngredients,
      ...missingIngredients
    ])
  );

const encodedSteps =
  encodeURIComponent(
    JSON.stringify(steps)
  );

          const coreIngredientsHtml =
  requestedRecipeId > 0
    ? ""
    : hasAllCoreIngredients
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
  data-display-name="${escapeHtml(recipeName)}"
  data-image-path="${escapeHtml(imagePath)}"
  data-filter-text="${escapeHtml(filterText)}"
  data-match-percentage="${matchPercentage}"
  data-matched-count="${matchedCount}"
  data-ready-to-cook="${hasAllCoreIngredients}"
  data-is-favorite="${isFavorite}"
  data-description="${escapeHtml(recipe.description || "")}"
  data-prep-time="${Number(recipe.prep_time) || 0}"
  data-cook-time="${Number(recipe.cook_time) || 0}"
  data-servings="${Number(recipe.servings) || 0}"
  data-all-ingredients="${encodedAllIngredients}"
  data-recipe-steps="${encodedSteps}"
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

        <div class="recipe-top">

<div class="recipe-title-row">
  <h4>
    ${escapeHtml(recipeName)}
  </h4>

  <div class="recipe-title-actions">

    <button
      type="button"
      class="share-recipe-btn"
      data-recipe-name="${escapeHtml(recipeName)}"
      aria-label="Share ${escapeHtml(recipeName)}"
      title="Share recipe"
    >
      🔗
    </button>

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
</div>

${
  requestedRecipeId > 0
    ? ""
    : hasAllCoreIngredients
      ? `
          <div class="ready-cook-badge is-ready">
            ✅ Ready to Cook
          </div>
        `
      : `
          <div class="ready-cook-badge is-missing">
            ⚠️ Missing Core Ingredients
          </div>
        `
}

<div
  class="recipe-rating"
  data-recipe-id="${recipeId}"
>
  <div class="rating-stars">
    <button type="button" class="rating-star" data-rating="1">★</button>
    <button type="button" class="rating-star" data-rating="2">★</button>
    <button type="button" class="rating-star" data-rating="3">★</button>
    <button type="button" class="rating-star" data-rating="4">★</button>
    <button type="button" class="rating-star" data-rating="5">★</button>
  </div>

  <div class="rating-summary">
    Not rated yet
  </div>
</div>

<div
  class="recipe-review-section"
  data-recipe-id="${recipeId}"
>

  <div class="review-action-buttons">

    <button
      type="button"
      class="btn btn-outline toggle-reviews-btn"
    >
      💬 Reviews
    </button>

    <button
      type="button"
      class="btn btn-outline toggle-write-review-btn"
    >
      ✍ Write a Review
    </button>

  </div>

  <div
    class="write-review-panel"
    hidden
  >

    <textarea
      class="review-input"
      rows="3"
      maxlength="500"
      placeholder="Write your review..."
    ></textarea>

    <button
      type="button"
      class="btn btn-primary post-review-btn"
      data-recipe-id="${recipeId}"
    >
      Post Review
    </button>

  </div>

  <div
    class="reviews-panel"
    hidden
  >

    <div
      class="reviews-list"
      data-recipe-id="${recipeId}"
    >
      <div class="review-loading">
        Loading reviews...
      </div>
    </div>

  </div>

</div>

${
  requestedRecipeId > 0
    ? ""
    : `
        <div class="tags">
          <span class="tag ${matchClass}">
            ${matchPercentage}% match
          </span>

          <span class="tag">
            ${matchedCount}/${totalIngredients} ingredients
          </span>
        </div>
      `
}
        </div>

       ${
  requestedRecipeId > 0
    ? ""
    : `
        <div class="small">
          <strong>You have:</strong>
          ${matchedHtml}
        </div>

        <div class="small">
          <strong>Still needed:</strong>
          ${missingHtml}
        </div>

        ${coreIngredientsHtml}
      `
}

<div class="shopping-recipe-action">
  <button
    type="button"
    class="btn btn-outline add-shopping-btn"
    data-shopping-items="${encodedMissingIngredients}"
    data-recipe-name="${escapeHtml(recipeName)}"
    ${missingIngredients.length === 0 ? "disabled" : ""}
  >
    ${
      missingIngredients.length === 0
        ? "✅ No Missing Ingredients"
        : "🛒 Add Missing Ingredients"
    }
  </button>
</div>

<div class="recipe-print-action">
  <button
    type="button"
    class="btn btn-outline print-recipe-btn"
  >
    🖨 Print Recipe
  </button>
</div>

<div class="recipe-details">

  <div class="recipe-time-item">
    ⏱ Prep:
    <strong>
      ${escapeHtml(recipe.prep_time || "Not specified")}
      ${recipe.prep_time ? "min" : ""}
    </strong>
  </div>

  <div class="recipe-time-item">
    🔥 Cook:
    <strong>
      ${escapeHtml(recipe.cook_time || "Not specified")}
      ${recipe.cook_time ? "min" : ""}
    </strong>
  </div>

  <div class="recipe-timer-controls">
  <button
    type="button"
    class="start-timer-btn"
    data-minutes="${Number(recipe.cook_time) || 0}"
  >
    ⏱ Start Timer
  </button>

  <div
    class="recipe-timer"
    aria-live="polite"
  ></div>
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
    ${escapeHtml(recipe.servings || "Not specified")}
    ${
      recipe.servings
        ? "people"
        : ""
    }
  </div>

  <div class="recipe-difficulty-item">
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

/* Load reviews for each displayed recipe */
resultsEl
  .querySelectorAll(".reviews-list")
  .forEach((reviewsList) => {

    const recipeId =
      Number(
        reviewsList.dataset.recipeId
      ) || 0;

    loadRecipeReviews(
      recipeId,
      reviewsList
    );
  });

const hasPerfectMatch =
  recipes.some(
          (recipe) =>
            Number(
              recipe.match_percentage
            ) === 100
        );

      if (hasPerfectMatch) {
        showToast(
          "Perfect Match! Everything you need is available. Enjoy cooking!",
          "🎉"
        );

        celebratePerfectMatch();
      }
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

// ---------- Open Recipe of the Day ----------
if (
  requestedRecipeId > 0 &&
  suggestBtn
) {
  window.addEventListener("load", () => {
    suggestBtn.click();
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

// ---------- Recipe Rating ----------
if (resultsEl) {
  resultsEl.addEventListener(
    "click",
    async (event) => {

      const star =
        event.target.closest(".rating-star");

      if (!star) {
        return;
      }

      const ratingBox =
        star.closest(".recipe-rating");

      if (!ratingBox) {
        return;
      }

      const recipeId =
        Number(ratingBox.dataset.recipeId) || 0;

      const rating =
        Number(star.dataset.rating) || 0;

      if (
        recipeId <= 0 ||
        rating < 1 ||
        rating > 5
      ) {
        return;
      }

      try {

        const response = await fetch(
          "rate_recipe.php",
          {
            method: "POST",

            headers: {
              "Content-Type": "application/json"
            },

            body: JSON.stringify({
              recipe_id: recipeId,
              rating: rating
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
            "Invalid rating response:",
            responseText
          );

          throw new Error(
            "rate_recipe.php did not return valid JSON."
          );
        }

        if (
          !response.ok ||
          data.success !== true
        ) {
          throw new Error(
            data.message ||
            "Unable to save rating."
          );
        }

        const stars =
          ratingBox.querySelectorAll(
            ".rating-star"
          );

        stars.forEach((button) => {

          const value =
            Number(button.dataset.rating);

          button.classList.toggle(
            "active",
            value <= rating
          );
        });

        const summary =
          ratingBox.querySelector(
            ".rating-summary"
          );

        if (summary) {

          const ratingCount =
            Number(data.rating_count) || 0;

          summary.textContent =
            `${data.average_rating} / 5 ` +
            `(${ratingCount} rating${
              ratingCount === 1
                ? ""
                : "s"
            })`;
        }

        showToast(
          "Rating saved!",
          "⭐"
        );

      } catch (error) {

        console.error(
          "Rating error:",
          error
        );

        showToast(
          error.message ||
          "Unable to save rating.",
          "⚠️"
        );
      }
    }
  );
}

// ---------- Load Recipe Reviews ----------
async function loadRecipeReviews(
  recipeId,
  reviewsList
) {
  if (!recipeId || !reviewsList) {
    return;
  }

  try {

    const response = await fetch(
      `get_reviews.php?recipe_id=${encodeURIComponent(recipeId)}`
    );

    const responseText =
      await response.text();

    let data;

    try {
      data = JSON.parse(responseText);
    } catch (jsonError) {

      console.error(
        "Invalid reviews response:",
        responseText
      );

      throw new Error(
        "get_reviews.php did not return valid JSON."
      );
    }

    if (
      !response.ok ||
      data.success !== true
    ) {
      throw new Error(
        data.message ||
        "Unable to load reviews."
      );
    }

    const reviews =
      Array.isArray(data.reviews)
        ? data.reviews
        : [];

    if (reviews.length === 0) {

      reviewsList.innerHTML = `
        <div class="no-reviews">
          No reviews yet. Be the first to review this recipe.
        </div>
      `;

      return;
    }

   let currentReviewIndex = 0;

function renderCurrentReview() {

  const review =
    reviews[currentReviewIndex];

  const date =
    review.created_at
      ? new Date(
          review.created_at.replace(" ", "T")
        ).toLocaleDateString()
      : "";

  reviewsList.innerHTML = `
    <div class="reviews-heading">
      💬 Reviews (${reviews.length})
    </div>

    <div class="review-item">

      <div class="review-user">
        ${escapeHtml(
          review.username || "User"
        )}
      </div>

      <div class="review-text">
        ${escapeHtml(
          review.review_text || ""
        )}
      </div>

      <div class="review-date">
        ${escapeHtml(date)}
      </div>

    </div>

    <div class="review-navigation">

      <button
        type="button"
        class="btn btn-outline review-prev-btn"
        ${currentReviewIndex === 0 ? "disabled" : ""}
      >
        ← Previous
      </button>

      <span class="review-page-info">
        ${currentReviewIndex + 1} of ${reviews.length}
      </span>

      <button
        type="button"
        class="btn btn-primary review-next-btn"
        ${
          currentReviewIndex === reviews.length - 1
            ? "disabled"
            : ""
        }
      >
        Next →
      </button>

    </div>
  `;

  const prevBtn =
    reviewsList.querySelector(
      ".review-prev-btn"
    );

  const nextBtn =
    reviewsList.querySelector(
      ".review-next-btn"
    );

  if (prevBtn) {
    prevBtn.addEventListener(
      "click",
      () => {

        if (currentReviewIndex > 0) {
          currentReviewIndex--;

          renderCurrentReview();
        }
      }
    );
  }

  if (nextBtn) {
    nextBtn.addEventListener(
      "click",
      () => {

        if (
          currentReviewIndex <
          reviews.length - 1
        ) {
          currentReviewIndex++;

          renderCurrentReview();
        }
      }
    );
  }
}

renderCurrentReview();

  } catch (error) {

    console.error(
      "Unable to load reviews:",
      error
    );

    reviewsList.innerHTML = `
      <div class="no-reviews">
        Unable to load reviews.
      </div>
    `;
  }
}

// ---------- Recipe Reviews ----------
if (resultsEl) {
  resultsEl.addEventListener(
    "click",
    async (event) => {

      const toggleReviewsBtn =
  event.target.closest(
    ".toggle-reviews-btn"
  );

if (toggleReviewsBtn) {

  const reviewSection =
    toggleReviewsBtn.closest(
      ".recipe-review-section"
    );

  if (!reviewSection) {
    return;
  }

  const reviewsPanel =
    reviewSection.querySelector(
      ".reviews-panel"
    );

  const writePanel =
    reviewSection.querySelector(
      ".write-review-panel"
    );

  if (reviewsPanel) {
    reviewsPanel.hidden =
      !reviewsPanel.hidden;
  }

  if (writePanel) {
    writePanel.hidden = true;
  }

  return;
}


const toggleWriteReviewBtn =
  event.target.closest(
    ".toggle-write-review-btn"
  );

if (toggleWriteReviewBtn) {

  const reviewSection =
    toggleWriteReviewBtn.closest(
      ".recipe-review-section"
    );

  if (!reviewSection) {
    return;
  }

  const writePanel =
    reviewSection.querySelector(
      ".write-review-panel"
    );

  const reviewsPanel =
    reviewSection.querySelector(
      ".reviews-panel"
    );

  if (writePanel) {
    writePanel.hidden =
      !writePanel.hidden;
  }

  if (reviewsPanel) {
    reviewsPanel.hidden = true;
  }

  return;
}

      const reviewBtn =
        event.target.closest(".post-review-btn");

      if (!reviewBtn) {
        return;
      }

      const reviewSection =
        reviewBtn.closest(
          ".recipe-review-section"
        );

      if (!reviewSection) {
        return;
      }

      const recipeId =
        Number(
          reviewSection.dataset.recipeId
        ) || 0;

      const reviewInput =
        reviewSection.querySelector(
          ".review-input"
        );

      if (!reviewInput) {
        return;
      }

      const reviewText =
        reviewInput.value.trim();

      if (recipeId <= 0) {
        return;
      }

      if (reviewText === "") {
        showToast(
          "Please write a review first.",
          "⚠️"
        );
        return;
      }

      reviewBtn.disabled = true;
      reviewBtn.textContent = "Posting...";

      try {

        const response = await fetch(
          "save_review.php",
          {
            method: "POST",

            headers: {
              "Content-Type":
                "application/json"
            },

            body: JSON.stringify({
              recipe_id: recipeId,
              review_text: reviewText
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
            "Invalid review response:",
            responseText
          );

          throw new Error(
            "save_review.php did not return valid JSON."
          );
        }

        if (
          !response.ok ||
          data.success !== true
        ) {
          throw new Error(
            data.message ||
            "Unable to post review."
          );
        }

        reviewInput.value = "";

        const reviewsList =
  reviewSection.querySelector(
    ".reviews-list"
  );

if (reviewsList) {
  await loadRecipeReviews(
    recipeId,
    reviewsList
  );
}

        showToast(
          "Review posted!",
          "💬"
        );

      } catch (error) {

        console.error(
          "Review error:",
          error
        );

        showToast(
          error.message ||
          "Unable to post review.",
          "⚠️"
        );

      } finally {

        reviewBtn.disabled = false;
        reviewBtn.textContent =
          "Post Review";
      }
    }
  );
}

// ---------- Share Recipe ----------
if (resultsEl) {
  resultsEl.addEventListener(
    "click",
    async (event) => {
      const shareBtn =
        event.target.closest(
          ".share-recipe-btn"
        );

      if (!shareBtn) {
        return;
      }

      const recipeCard =
        shareBtn.closest(".recipe");

      if (!recipeCard) {
        return;
      }

      const recipeName =
        shareBtn.dataset.recipeName ||
        "Wasfatna Recipe";

      const matchedText =
        recipeCard.querySelector(
          ".tags"
        )?.innerText || "";

      const neededText =
        Array.from(
          recipeCard.querySelectorAll(
            ".small"
          )
        )
          .map((element) =>
            element.innerText.trim()
          )
          .filter(Boolean)
          .join("\n");

      const shareText =
        `${recipeName}\n\n` +
        `${matchedText}\n\n` +
        `${neededText}\n\n` +
        "Shared from Wasfatna";

      try {
        if (navigator.share) {
          await navigator.share({
            title: recipeName,
            text: shareText
          });

          showToast(
            "Recipe shared.",
            "🔗"
          );

          return;
        }

        await navigator.clipboard.writeText(
          shareText
        );

        showToast(
          "Recipe details copied.",
          "📋"
        );
      } catch (error) {
        if (
          error.name === "AbortError"
        ) {
          return;
        }

        console.error(
          "Unable to share recipe:",
          error
        );

        showToast(
          "Unable to share this recipe.",
          "⚠️"
        );
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

        const recipeName =
  addShoppingBtn.dataset.recipeName || "Recipe";

addIngredientsToShoppingList(
  missingItems,
  recipeName
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

// ---------- Cooking Timer ----------

const activeRecipeTimers = new WeakMap();

if (resultsEl) {
  resultsEl.addEventListener(
    "click",
    (event) => {
      const timerBtn =
        event.target.closest(
          ".start-timer-btn"
        );

      if (!timerBtn) {
        return;
      }

      const timerControls =
        timerBtn.closest(
          ".recipe-timer-controls"
        );

      const timerDisplay =
        timerControls?.querySelector(
          ".recipe-timer"
        );

      if (!timerDisplay) {
        return;
      }

      const cookMinutes =
        Number(timerBtn.dataset.minutes);

      if (
        !Number.isFinite(cookMinutes) ||
        cookMinutes <= 0
      ) {
        showToast(
          "Cooking time is not available.",
          "⚠️"
        );

        return;
      }

      const existingTimer =
        activeRecipeTimers.get(timerBtn);

      if (existingTimer) {
        clearInterval(existingTimer);
        activeRecipeTimers.delete(timerBtn);

        timerDisplay.textContent = "";
        timerBtn.textContent =
          "⏱ Start Timer";

        showToast(
          "Cooking timer cancelled.",
          "⏹️"
        );

        return;
      }

      let remainingSeconds = Math.round(cookMinutes * 60);

      function updateTimerDisplay() {
        const minutes =
          Math.floor(
            remainingSeconds / 60
          );

        const seconds =
          remainingSeconds % 60;

        timerDisplay.textContent =
          `${String(minutes).padStart(2, "0")}:` +
          `${String(seconds).padStart(2, "0")}`;
      }

      updateTimerDisplay();

      timerBtn.textContent =
        "⏹ Cancel Timer";

      const intervalId =
        setInterval(() => {
          remainingSeconds -= 1;

          if (remainingSeconds <= 0) {
            clearInterval(intervalId);
            activeRecipeTimers.delete(
              timerBtn
            );

            timerDisplay.textContent =
              "⏰ Your recipe is ready!";

            timerBtn.textContent =
              "⏱ Start Again";

            showToast(
              "Your recipe is ready!",
              "⏰"
            );

            return;
          }

          updateTimerDisplay();
        }, 1000);

      activeRecipeTimers.set(
        timerBtn,
        intervalId
      );

      showToast(
        `Cooking timer started for ${cookMinutes} minute${
          cookMinutes === 1 ? "" : "s"
        }.`,
        "⏱️"
      );
    }
  );
}

// ---------- Print Recipe ----------

if (resultsEl) {
  resultsEl.addEventListener(
    "click",
    (event) => {
      const printRecipeBtn =
        event.target.closest(
          ".print-recipe-btn"
        );

      if (!printRecipeBtn) {
        return;
      }

      const recipeCard =
        printRecipeBtn.closest(".recipe");

      if (!recipeCard) {
        return;
      }

      const recipeName =
        recipeCard.dataset.displayName ||
        "Wasfatna Recipe";

      const description =
        recipeCard.dataset.description || "";

      const imagePath =
        recipeCard.dataset.imagePath ||
        "images/default_recipe.png";

      const prepTime =
        Number(recipeCard.dataset.prepTime) || 0;

      const cookTime =
        Number(recipeCard.dataset.cookTime) || 0;

      const totalTime =
        prepTime + cookTime;

      const servings =
        Number(recipeCard.dataset.servings) || 0;

      let ingredients = [];
      let steps = [];

      try {
        ingredients = JSON.parse(
          decodeURIComponent(
            recipeCard.dataset.allIngredients || "[]"
          )
        );

        steps = JSON.parse(
          decodeURIComponent(
            recipeCard.dataset.recipeSteps || "[]"
          )
        );
      } catch (error) {
        console.error(
          "Unable to read recipe print data:",
          error
        );

        showToast(
          "Unable to prepare this recipe for printing.",
          "⚠️"
        );

        return;
      }

      const ingredientsHtml =
        ingredients.length
          ? ingredients
              .map((ingredient) => {
                const name =
                  escapeHtml(
                    ingredient.name || ""
                  );

                const quantity =
                  ingredient.quantity
                    ? ` — ${escapeHtml(
                        ingredient.quantity
                      )}`
                    : "";

                return `
                  <li>
                    ${name}${quantity}
                  </li>
                `;
              })
              .join("")
          : `
              <li>
                No ingredients available.
              </li>
            `;

      const stepsHtml =
        steps.length
          ? steps
              .map(
                (step) => `
                  <li>
                    ${escapeHtml(step)}
                  </li>
                `
              )
              .join("")
          : `
              <li>
                No preparation steps available.
              </li>
            `;

      const printWindow =
        window.open("", "_blank");

      if (!printWindow) {
        showToast(
          "Please allow pop-ups to print the recipe.",
          "⚠️"
        );

        return;
      }

      printWindow.document.write(`
        <!doctype html>
        <html lang="en">
        <head>
          <meta charset="utf-8">
          <title>${escapeHtml(recipeName)}</title>

          <style>
            body{
              max-width:850px;
              margin:0 auto;
              padding:40px;
              color:#111;
              font-family:Arial,sans-serif;
              line-height:1.5;
            }

            h1{
              margin:0 0 8px;
            }

            .description{
              margin:0 0 18px;
              color:#444;
            }

            .recipe-image{
              width:100%;
              max-width:520px;
              height:300px;
              margin:16px 0 22px;
              object-fit:cover;
              border-radius:14px;
            }

            .details{
              display:flex;
              flex-wrap:wrap;
              gap:10px;
              margin:18px 0;
            }

            .detail{
              padding:8px 12px;
              border:1px solid #ccc;
              border-radius:999px;
              font-weight:700;
            }

            h2{
              margin-top:28px;
              padding-bottom:7px;
              border-bottom:1px solid #ddd;
            }

            li{
              margin-bottom:8px;
            }

            .footer{
              margin-top:40px;
              padding-top:14px;
              border-top:1px solid #ddd;
              color:#666;
              font-size:12px;
            }

            @media print{
              body{
                padding:20px;
              }
            }
          </style>
        </head>

        <body>
          <h1>${escapeHtml(recipeName)}</h1>

          ${
            description
              ? `
                <p class="description">
                  ${escapeHtml(description)}
                </p>
              `
              : ""
          }

          <img
            src="${escapeHtml(imagePath)}"
            alt="${escapeHtml(recipeName)}"
            class="recipe-image"
          >

          <div class="details">
            <div class="detail">
              ⏱ Prep:
              ${prepTime || "Not specified"}
              ${prepTime ? "min" : ""}
            </div>

            <div class="detail">
              🔥 Cook:
              ${cookTime || "Not specified"}
              ${cookTime ? "min" : ""}
            </div>

            <div class="detail">
              ⌛ Total:
              ${totalTime || "Not specified"}
              ${totalTime ? "min" : ""}
            </div>

            <div class="detail">
              🍽 Serves:
              ${servings || "Not specified"}
            </div>
          </div>

          <h2>Ingredients</h2>

          <ul>
            ${ingredientsHtml}
          </ul>

          <h2>Steps</h2>

          <ol>
            ${stepsHtml}
          </ol>

          <div class="footer">
            Generated by Wasfatna —
            University of Bahrain Senior Project
          </div>
        </body>
        </html>
      `);

      printWindow.document.close();
      printWindow.focus();

      printWindow.addEventListener(
        "load",
        () => {
          printWindow.print();
        }
      );
    }
  );
}

// ---------- Recently Viewed Recipes ----------

const RECENTLY_VIEWED_KEY =
  "wasfatna-recently-viewed";

const MAX_RECENTLY_VIEWED = 5;

function loadRecentlyViewed() {
  try {
    const savedRecipes =
      localStorage.getItem(
        RECENTLY_VIEWED_KEY
      );

    if (!savedRecipes) {
      return [];
    }

    const parsedRecipes =
      JSON.parse(savedRecipes);

    return Array.isArray(parsedRecipes)
      ? parsedRecipes
      : [];
  } catch (error) {
    console.error(
      "Unable to load recently viewed recipes:",
      error
    );

    return [];
  }
}

function saveRecentlyViewedRecipe(
  recipeName,
  imagePath
) {
  const cleanName =
    String(recipeName || "").trim();

  if (!cleanName) {
    return;
  }

  let recipes = loadRecentlyViewed();

  // Remove an older copy of the same recipe.
  recipes = recipes.filter(
    (recipe) =>
      normalizeIngredient(recipe.name) !==
      normalizeIngredient(cleanName)
  );

  // Add the newest recipe to the beginning.
  recipes.unshift({
    name: cleanName,
    image:
      String(imagePath || "").trim()
  });

  // Keep only the latest five recipes.
  recipes = recipes.slice(
    0,
    MAX_RECENTLY_VIEWED
  );

  localStorage.setItem(
    RECENTLY_VIEWED_KEY,
    JSON.stringify(recipes)
  );

  renderRecentlyViewed();
}

function renderRecentlyViewed() {
  if (
    !recentlyViewedSection ||
    !recentlyViewedList
  ) {
    return;
  }

  const recipes = loadRecentlyViewed();

  if (recipes.length === 0) {
    recentlyViewedSection.hidden = true;
    recentlyViewedList.innerHTML = "";
    return;
  }

  recentlyViewedSection.hidden = false;

  recentlyViewedList.innerHTML =
    recipes
      .map((recipe) => {
        const imagePath =
          recipe.image ||
          "images/default_recipe.png";

        return `
          <div class="recently-viewed-item">
            <img
              src="${escapeHtml(imagePath)}"
              alt="${escapeHtml(recipe.name)}"
              class="recently-viewed-image"
              onerror="
                this.onerror=null;
                this.src='images/default_recipe.png';
              "
            >

            <span class="recently-viewed-name">
              ${escapeHtml(recipe.name)}
            </span>
          </div>
        `;
      })
      .join("");
}

if (clearRecentlyViewedBtn) {
  clearRecentlyViewedBtn.addEventListener(
    "click",
    () => {
      localStorage.removeItem(
        RECENTLY_VIEWED_KEY
      );

      renderRecentlyViewed();

      showToast(
        "Recently viewed history cleared.",
        "🗑️"
      );
    }
  );
}

// Display saved history when the page opens.
renderRecentlyViewed();

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

  const displayedRecipe =
  filteredCards[currentRecipeIndex];

saveRecentlyViewedRecipe(
  displayedRecipe.dataset.displayName ||
    displayedRecipe.dataset.recipeName,
  displayedRecipe.dataset.imagePath
);

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
        Sign out of Wasfatna?
      </h3>

      <p class="logout-text">
        You will need to sign in again to access your favorites and preferences.
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
          Sign Out
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

// ---------- Homepage Recipe Slideshow ----------

const homeRecipeSlider =
  document.getElementById("homeRecipeSlider");

if (homeRecipeSlider) {

  const homeImages = [
    "images/chicken_machboos.png",
    "images/lamb_machboos.png",
    "images/fish_machboos.png",
    "images/bahraini_halwa.png"
  ];

  let currentHomeImage = 0;

  setInterval(() => {

    homeRecipeSlider.style.opacity = "0";

    setTimeout(() => {

      currentHomeImage++;

      if (currentHomeImage >= homeImages.length) {
        currentHomeImage = 0;
      }

      homeRecipeSlider.src =
        homeImages[currentHomeImage];

      homeRecipeSlider.style.opacity = "1";

    }, 300);

  }, 3500);

}

// ---------- Show / Hide Password ----------

const passwordInput =
  document.getElementById("passwordInput");

const togglePassword =
  document.getElementById("togglePassword");

if (passwordInput && togglePassword) {

  togglePassword.addEventListener("click", () => {

    if (passwordInput.type === "password") {

      passwordInput.type = "text";
      togglePassword.textContent = "🙈";
      togglePassword.setAttribute(
        "aria-label",
        "Hide password"
      );

    } else {

      passwordInput.type = "password";
      togglePassword.textContent = "👁";
      togglePassword.setAttribute(
        "aria-label",
        "Show password"
      );

    }

  });

}

// ---------- Forgot Password ----------

const forgotPasswordBtn =
  document.getElementById("forgotPasswordBtn");

const forgotPasswordMessage =
  document.getElementById(
    "forgotPasswordMessage"
  );

if (
  forgotPasswordBtn &&
  forgotPasswordMessage
) {
  forgotPasswordBtn.addEventListener(
    "click",
    () => {
      const isHidden =
        forgotPasswordMessage.hidden;

      forgotPasswordMessage.hidden =
        !isHidden;

      forgotPasswordBtn.textContent = "Forgot Password?";
    }
  );
}

// ---------- Sign-in loading button ----------

const signinForm =
  document.getElementById("signinForm");

const signinBtn =
  document.getElementById("signinBtn");

if (signinForm && signinBtn) {
  signinForm.addEventListener(
    "submit",
    (event) => {
      if (!signinForm.checkValidity()) {
        return;
      }

      const buttonText =
        signinBtn.querySelector(
          ".signin-btn-text"
        );

      const spinner =
        signinBtn.querySelector(
          ".signin-spinner"
        );

      signinBtn.disabled = true;

      if (buttonText) {
        buttonText.textContent =
          "Signing in...";
      }

      if (spinner) {
        spinner.hidden = false;
      }
    }
  );
}

// ---------- Sign Up Page ----------

const signupPassword =
  document.getElementById("signupPassword");

const confirmPassword =
  document.getElementById("confirmPassword");

const toggleSignupPassword =
  document.getElementById("toggleSignupPassword");

const toggleConfirmPassword =
  document.getElementById("toggleConfirmPassword");

const passwordStrengthBar =
  document.getElementById("passwordStrengthBar");

const passwordStrengthText =
  document.getElementById("passwordStrengthText");

const passwordMatchMessage =
  document.getElementById("passwordMatchMessage");

const signupForm =
  document.getElementById("signupForm");

const signupBtn =
  document.getElementById("signupBtn");

function togglePasswordVisibility(
  input,
  button
) {
  if (!input || !button) {
    return;
  }

  const isHidden =
    input.type === "password";

  input.type =
    isHidden ? "text" : "password";

  button.textContent =
    isHidden ? "🙈" : "👁";

  button.setAttribute(
    "aria-label",
    isHidden
      ? "Hide password"
      : "Show password"
  );
}

if (
  toggleSignupPassword &&
  signupPassword
) {
  toggleSignupPassword.addEventListener(
    "click",
    () => {
      togglePasswordVisibility(
        signupPassword,
        toggleSignupPassword
      );
    }
  );
}

if (
  toggleConfirmPassword &&
  confirmPassword
) {
  toggleConfirmPassword.addEventListener(
    "click",
    () => {
      togglePasswordVisibility(
        confirmPassword,
        toggleConfirmPassword
      );
    }
  );
}

function updatePasswordStrength() {
  if (
    !signupPassword ||
    !passwordStrengthBar ||
    !passwordStrengthText
  ) {
    return;
  }

  const password =
    signupPassword.value;

  let score = 0;

  if (password.length >= 8) {
    score++;
  }

  if (/[A-Z]/.test(password)) {
    score++;
  }

  if (/[a-z]/.test(password)) {
    score++;
  }

  if (/[0-9]/.test(password)) {
    score++;
  }

  if (/[^A-Za-z0-9]/.test(password)) {
    score++;
  }

  passwordStrengthBar.classList.remove(
    "weak",
    "medium",
    "strong"
  );

  if (password.length === 0) {
    passwordStrengthText.textContent =
      "Password strength";

    return;
  }

  if (score <= 2) {
    passwordStrengthBar.classList.add(
      "weak"
    );

    passwordStrengthText.textContent =
      "Weak";
  } else if (score <= 4) {
    passwordStrengthBar.classList.add(
      "medium"
    );

    passwordStrengthText.textContent =
      "Medium";
  } else {
    passwordStrengthBar.classList.add(
      "strong"
    );

    passwordStrengthText.textContent =
      "Strong";
  }
}

function updatePasswordMatch() {
  if (
    !signupPassword ||
    !confirmPassword ||
    !passwordMatchMessage
  ) {
    return;
  }

  passwordMatchMessage.classList.remove(
    "is-match",
    "is-not-match"
  );

  if (confirmPassword.value === "") {
    passwordMatchMessage.textContent = "";
    return;
  }

  if (
    signupPassword.value ===
    confirmPassword.value
  ) {
    passwordMatchMessage.textContent =
      "✓ Passwords match";

    passwordMatchMessage.classList.add(
      "is-match"
    );
  } else {
    passwordMatchMessage.textContent =
      "✕ Passwords do not match";

    passwordMatchMessage.classList.add(
      "is-not-match"
    );
  }
}

if (signupPassword) {
  signupPassword.addEventListener(
    "input",
    () => {
      updatePasswordStrength();
      updatePasswordMatch();
    }
  );
}

if (confirmPassword) {
  confirmPassword.addEventListener(
    "input",
    updatePasswordMatch
  );
}

if (signupForm && signupBtn) {
  signupForm.addEventListener(
    "submit",
    (event) => {
      if (!signupForm.checkValidity()) {
        return;
      }

      if (
        signupPassword &&
        confirmPassword &&
        signupPassword.value !==
          confirmPassword.value
      ) {
        event.preventDefault();

        updatePasswordMatch();
        confirmPassword.focus();

        return;
      }

      const buttonText =
        signupBtn.querySelector(
          ".signup-btn-text"
        );

      const spinner =
        signupBtn.querySelector(
          ".signup-spinner"
        );

      signupBtn.disabled = true;

      if (buttonText) {
        buttonText.textContent =
          "Creating account...";
      }
      
      if (spinner) {
        spinner.hidden = false;
      }
    }
  );
}
