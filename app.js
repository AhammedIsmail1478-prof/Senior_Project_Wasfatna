// ---------- Helpers ----------
function normalizeIngredient(str) {
  return str.trim().toLowerCase();
}

function parseIngredients(text) {
  return text
    .split(",")
    .map(normalizeIngredient)
    .filter(Boolean);
}

function uniq(arr) {
  return [...new Set(arr)];
}

// ---------- Small recipe dataset (prototype) ----------
const RECIPES = [
  {
    id: "r1",
    name: "One-Pot Chicken Rice",
    tags: ["high-protein", "medium", "balanced"],
    required: ["chicken", "rice", "onion"],
    optional: ["tomato", "garlic", "yogurt", "spices"],
    glutenFree: true,
    vegetarian: false,
    lactoseFree: true,
    steps: [
      "Sauté onion (and garlic if available) in a pot.",
      "Add chicken pieces and brown lightly.",
      "Add rice + water/stock, then simmer until rice is cooked.",
      "Adjust seasoning. Add tomato for extra flavor if you have it."
    ],
    substitutions: {
      chicken: ["beans", "chickpeas", "tofu"],
      rice: ["quinoa", "potato"],
      yogurt: ["coconut yogurt", "skip it"]
    }
  },
  {
    id: "r2",
    name: "Vegetable Omelette",
    tags: ["healthy", "mild", "balanced"],
    required: ["eggs"],
    optional: ["onion", "tomato", "cheese", "pepper", "spinach"],
    glutenFree: true,
    vegetarian: true,
    lactoseFree: false,
    steps: [
      "Whisk eggs with salt and pepper.",
      "Sauté chopped vegetables you have.",
      "Pour eggs, cook until set, fold and serve."
    ],
    substitutions: {
      eggs: ["chickpea flour omelette (besan)", "tofu scramble"],
      cheese: ["lactose-free cheese", "skip it"]
    }
  },
  {
    id: "r3",
    name: "Tomato Pasta (Quick)",
    tags: ["medium", "balanced"],
    required: ["tomato", "pasta"],
    optional: ["onion", "garlic", "cheese", "spices"],
    glutenFree: false,
    vegetarian: true,
    lactoseFree: false,
    steps: [
      "Boil pasta.",
      "Cook onion/garlic, add tomato to make a sauce.",
      "Mix pasta with sauce. Add cheese if desired."
    ],
    substitutions: {
      pasta: ["gluten-free pasta", "rice noodles"],
      cheese: ["lactose-free cheese", "skip it"]
    }
  },
  {
    id: "r4",
    name: "Chickpea Salad Bowl",
    tags: ["healthy", "mild", "low-cal"],
    required: ["chickpeas"],
    optional: ["tomato", "onion", "cucumber", "lemon", "yogurt"],
    glutenFree: true,
    vegetarian: true,
    lactoseFree: false,
    steps: [
      "Rinse chickpeas.",
      "Chop vegetables you have and mix.",
      "Season with lemon, salt, pepper. Add yogurt dressing if you want."
    ],
    substitutions: {
      chickpeas: ["beans", "lentils"],
      yogurt: ["olive oil + lemon dressing", "coconut yogurt"]
    }
  }
];

// ---------- Filtering logic ----------
function matchesDiet(recipe, diet) {
  if (diet === "none") return true;
  if (diet === "vegetarian") return recipe.vegetarian === true;
  if (diet === "gluten-free") return recipe.glutenFree === true;
  if (diet === "lactose-free") return recipe.lactoseFree === true;
  return true;
}

function matchesPreferences(recipe, spice, sweetness, goal) {
  // tags on recipes are simple prototypes
  const tags = recipe.tags || [];

  // spice check (only if not "any")
  if (spice !== "any") {
    const okSpice =
      (spice === "mild" && tags.includes("mild")) ||
      (spice === "medium" && tags.includes("medium")) ||
      (spice === "spicy" && tags.includes("spicy"));

    // if recipe doesn't specify spice, allow it
    if (tags.some(t => ["mild", "medium", "spicy"].includes(t)) && !okSpice) return false;
  }

  // sweetness check (prototype)
  if (sweetness !== "any") {
    const okSweet =
      (sweetness === "low" && tags.includes("low")) ||
      (sweetness === "balanced" && tags.includes("balanced")) ||
      (sweetness === "sweet" && tags.includes("sweet"));
    if (tags.some(t => ["low", "balanced", "sweet"].includes(t)) && !okSweet) return false;
  }

  // goal check
  if (goal !== "any") {
    if (!tags.includes(goal)) return false;
  }

  return true;
}

function scoreRecipe(recipe, ingredients) {
  const have = new Set(ingredients);
  const requiredHave = recipe.required.filter(i => have.has(i)).length;
  const requiredMissing = recipe.required.filter(i => !have.has(i));
  const optionalHave = (recipe.optional || []).filter(i => have.has(i)).length;

  // score: prioritize required matches, then optional
  const score = requiredHave * 10 + optionalHave * 2 - requiredMissing.length * 6;

  return {
    score,
    requiredMissing
  };
}

function formatSubstitutions(missingList, recipe, diet) {
  if (!missingList.length) return null;

  const lines = [];
  for (const item of missingList) {
    const subs = (recipe.substitutions && recipe.substitutions[item]) ? recipe.substitutions[item] : [];
    if (subs.length) {
      lines.push(`Missing "${item}" → try: ${subs.join(", ")}`);
    } else {
      lines.push(`Missing "${item}" → no suggestion available (add later)`);
    }
  }

  // extra dietary notes
  if (diet === "vegetarian" && recipe.vegetarian === false) {
    lines.push("Diet note: this recipe is not vegetarian — consider swapping the main protein (e.g., beans/tofu).");
  }
  if (diet === "gluten-free" && recipe.glutenFree === false) {
    lines.push("Diet note: replace gluten items with gluten-free options (e.g., GF pasta).");
  }
  if (diet === "lactose-free" && recipe.lactoseFree === false) {
    lines.push("Diet note: avoid dairy or use lactose-free substitutes.");
  }

  return lines;
}

function tweakStepsForTaste(steps, spice, sweetness, goal) {
  const extra = [];

  if (spice === "spicy") extra.push("Make it spicier: add chili, hot sauce, or extra pepper gradually.");
  if (spice === "mild") extra.push("Keep it mild: reduce chili/pepper and use mild spices.");

  if (sweetness === "sweet") extra.push("Make it sweeter: add a small amount of honey/sugar (if suitable) to balance acidity.");
  if (sweetness === "low") extra.push("Lower sweetness: avoid sweet sauces; balance flavor with lemon, herbs, and spices.");

  if (goal === "healthy") extra.push("Healthier: use less oil, add more vegetables, and prefer grilling/boiling over frying.");
  if (goal === "low-cal") extra.push("Lower calories: reduce added fats, increase veggies, and control portion size.");
  if (goal === "high-protein") extra.push("Higher protein: add legumes/lean protein, or increase the main protein portion.");

  return [...steps, ...(extra.length ? ["— Preferences —", ...extra] : [])];
}

// ---------- DOM ----------
const ingredientsInput = document.getElementById("ingredientsInput");
const suggestBtn = document.getElementById("suggestBtn");
const clearBtn = document.getElementById("clearBtn");

const spiceEl = document.getElementById("spice");
const sweetnessEl = document.getElementById("sweetness");
const goalEl = document.getElementById("goal");
const dietEl = document.getElementById("diet");

const resultsEl = document.getElementById("results");
const resultsCount = document.getElementById("resultsCount");

// About panel
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

// Events
aboutBtn.addEventListener("click", openAbout);
aboutClose.addEventListener("click", closeAbout);
backdrop.addEventListener("click", closeAbout);

clearBtn.addEventListener("click", () => {
  ingredientsInput.value = "";
  resultsEl.innerHTML = `<div class="empty">No results yet — enter ingredients and click “Suggest Recipes”.</div>`;
  resultsCount.textContent = "0";
});

suggestBtn.addEventListener("click", () => {
  const ingredients = uniq(parseIngredients(ingredientsInput.value));
  const spice = spiceEl.value;
  const sweetness = sweetnessEl.value;
  const goal = goalEl.value;
  const diet = dietEl.value;

  if (!ingredients.length) {
    resultsEl.innerHTML = `<div class="empty">Please enter at least 1 ingredient (comma separated).</div>`;
    resultsCount.textContent = "0";
    return;
  }

  // Filter by diet + preference
  const candidates = RECIPES
    .filter(r => matchesDiet(r, diet))
    .filter(r => matchesPreferences(r, spice, sweetness, goal))
    .map(r => {
      const { score, requiredMissing } = scoreRecipe(r, ingredients);
      return { recipe: r, score, requiredMissing };
    })
    .sort((a, b) => b.score - a.score);

  // Keep only somewhat relevant results
  const finalList = candidates.filter(x => x.score > 2);

  resultsCount.textContent = String(finalList.length);

  if (!finalList.length) {
    resultsEl.innerHTML = `
      <div class="empty">
        No matching recipes found for these filters. Try removing a dietary restriction,
        or add more ingredients.
      </div>
    `;
    return;
  }

  resultsEl.innerHTML = finalList.map(({ recipe, requiredMissing }) => {
    const subs = formatSubstitutions(requiredMissing, recipe, diet);
    const personalizedSteps = tweakStepsForTaste(recipe.steps, spice, sweetness, goal);

    const tagHtml = (recipe.tags || []).map(t => `<span class="tag">${t}</span>`).join("");

    const missingHtml = requiredMissing.length
      ? `<div class="small"><strong>Missing required:</strong> ${requiredMissing.join(", ")}</div>`
      : `<div class="small"><strong>All required ingredients found ✅</strong></div>`;

    const subsHtml = subs
      ? `<div class="small"><strong>Substitutions / Notes:</strong><br>${subs.map(s => `• ${s}`).join("<br>")}</div>`
      : `<div class="small"><strong>Substitutions:</strong> none needed</div>`;

    const stepsHtml = `
      <div class="steps">
        <div class="small"><strong>Steps</strong></div>
        <ol>
          ${personalizedSteps.map(s => `<li>${s}</li>`).join("")}
        </ol>
      </div>
    `;

    return `
      <article class="recipe">
        <div class="recipe-top">
          <h4>${recipe.name}</h4>
          <div class="tags">${tagHtml}</div>
        </div>
        ${missingHtml}
        ${subsHtml}
        ${stepsHtml}
      </article>
    `;
  }).join("");
});