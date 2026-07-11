CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE recipes (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    recipe_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    prep_time INT,
    cook_time INT,
    servings INT,
    difficulty ENUM('Easy','Medium','Hard'),
    calories INT,
    image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (category_id)
    REFERENCES categories(category_id)
);

CREATE TABLE ingredients (
    ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    ingredient_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE recipe_ingredients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantity VARCHAR(50),

    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id),

    UNIQUE (recipe_id, ingredient_id)
);

CREATE TABLE recipe_steps (
    step_id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT NOT NULL,
    step_number INT,
    instruction TEXT,

    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id),

    UNIQUE (recipe_id, step_number)
);

INSERT INTO categories(category_name)
VALUES
('Main Course'),
('SeaFood'), 
('Soups'),
('Bread'),
('Breakfast'),
('Desserts'),
('Snacks'),
('Drinks'),
('Salad');

INSERT INTO recipes
(category_id,recipe_name,description,prep_time,cook_time,servings,difficulty,calories,image)

VALUES

(1,'Chicken Machboos','Traditional Bahraini spiced chicken rice.',20,60,6,'Medium',680,'chicken_machboos.png'),

(1,'Lamb Machboos','Traditional Bahraini lamb rice.',25,90,6,'Medium',780,'lamb_machboos.png'),

(1,'Fish Machboos','Spiced rice served with local fish.',20,45,5,'Medium',610,'fish_machboos.png'),

(1,'Muhammar','Sweet saffron rice served with fish.',20,40,5,'Easy',520,'muhammar.png'),

(1,'Ghoozi','Slow cooked lamb with fragrant rice.',30,120,8,'Hard',890,'ghoozi.png'),

(1,'Harees','Slow cooked wheat and meat.',20,180,6,'Medium',470,'harees.png'),

(1,'Thareed','Bread soaked in flavorful stew.',20,60,5,'Medium',520,'thareed.png'),

(1,'Chicken Madrouba','Creamy rice with shredded chicken.',20,70,6,'Medium',640,'chicken_madrouba.png'),

(1,'Fish Madrouba','Creamy fish rice dish.',20,60,5,'Medium',590,'fish_madrouba.png'),

(1,'Samak Mashwi','Traditional grilled Bahraini fish.',15,30,4,'Easy',390,'samak_mashwi.png'),

(1,'Qabooli Rice','Spiced rice with raisins and nuts.',20,55,6,'Medium',610,'qabooli_rice.png'),

(1,'Bahraini Style Biryani','Bahraini version of biryani.',30,75,6,'Medium',720,'bahraini_biryani.png'),

(1,'Chicken Saloona','Chicken cooked in vegetable gravy.',20,50,5,'Easy',460,'chicken_saloona.png'),

(1,'Lamb Saloona','Lamb stew with vegetables.',25,90,6,'Medium',620,'lamb_saloona.png'),

(1,'Vegetable Saloona','Mixed vegetable curry.',15,40,5,'Easy',310,'vegetable_saloona.png'),

(1,'Jasheed','Traditional shark meat curry.',20,60,5,'Medium',480,'jasheed.png');

INSERT INTO recipes
(category_id, recipe_name, description, prep_time, cook_time, servings, difficulty, calories, image)

VALUES

(2,'Fried Hammour','Crispy deep-fried hammour fish served with lemon and rice.',20,25,4,'Easy',520,'fried_hammour.png'),

(2,'Grilled Kingfish','Charcoal grilled kingfish seasoned with Bahraini spices.',20,30,4,'Easy',430,'grilled_kingfish.png'),

(2,'Shrimp Curry','Fresh shrimp cooked in a rich spicy curry sauce.',20,35,5,'Medium',480,'shrimp_curry.png'),

(2,'Fried Shrimp','Golden crispy fried shrimp served with dipping sauce.',15,20,4,'Easy',450,'fried_shrimp.png'),

(2,'Fish Curry','Tender fish cooked in aromatic curry gravy.',20,40,5,'Medium',510,'fish_curry.png'),

(2,'Seafood Saloona','Traditional Bahraini seafood stew with mixed vegetables.',25,45,6,'Medium',470,'seafood_saloona.png'),

(2,'Prawn Rice','Fragrant spiced rice cooked with juicy prawns.',25,45,5,'Medium',620,'prawn_rice.png'),

(2,'Fried Safi Fish','Traditional Bahraini fried safi fish with spices.',15,25,4,'Easy',410,'fried_safi_fish.png'),

(2,'Fish Stew','Slow-cooked fish stew with tomatoes and herbs.',20,40,5,'Medium',460,'fish_stew.png'),

(2,'Spicy Shrimp','Spicy sautéed shrimp with garlic and chili.',15,20,4,'Medium',390,'spicy_shrimp.png');

INSERT INTO recipes
(category_id, recipe_name, description, prep_time, cook_time, servings, difficulty, calories, image)

VALUES

(3,'Lentil Soup','Traditional lentil soup made with red lentils, vegetables, and aromatic spices.',15,35,4,'Easy',280,'lentil_soup.png'),

(3,'Chicken Soup','Comforting chicken soup with vegetables and flavorful herbs.',15,40,4,'Easy',320,'chicken_soup.png'),

(3,'Vegetable Soup','Healthy mixed vegetable soup prepared with fresh seasonal vegetables.',15,30,4,'Easy',210,'vegetable_soup.png'),

(3,'Harees Soup','Creamy wheat and meat soup inspired by traditional Bahraini harees.',20,90,5,'Medium',390,'harees_soup.png'),

(3,'Seafood Soup','Rich seafood soup made with fish, shrimp, and aromatic herbs.',20,45,5,'Medium',350,'seafood_soup.png');

INSERT INTO recipes
(category_id, recipe_name, description, prep_time, cook_time, servings, difficulty, calories, image)

VALUES

(4,'Khubz','Traditional Bahraini flatbread baked until soft and golden.',15,10,6,'Easy',220,'khubz.png'),

(4,'Khubz Tannour','Traditional tannour oven bread with a crispy crust and soft interior.',20,15,6,'Medium',240,'khubz_tannour.png'),

(4,'Regag Bread','Thin crispy Bahraini bread commonly served with curries and cheese.',15,10,4,'Easy',180,'regag_bread.png'),

(4,'Muhalla Bread','Soft sweet Bahraini bread flavored with saffron and cardamom.',20,20,6,'Medium',290,'muhalla_bread.png'),

(4,'Chebab','Traditional Bahraini pancakes flavored with saffron and cardamom.',15,20,4,'Easy',310,'chebab.png');

INSERT INTO recipes
(category_id, recipe_name, description, prep_time, cook_time, servings, difficulty, calories, image)

VALUES

(5,'Balaleet','Traditional Bahraini sweet vermicelli topped with a savory omelet.',15,20,4,'Easy',420,'balaleet.png'),

(5,'Beyd wa Tamat','Classic Bahraini breakfast of eggs cooked with tomatoes and spices.',10,15,2,'Easy',280,'beyd_wa_tamat.png'),

(5,'Bahraini Falafel','Crispy homemade falafel served with fresh vegetables and tahini.',20,15,4,'Medium',340,'bahraini_falafel.png'),

(5,'Labneh Plate','Creamy labneh served with olive oil, olives, and fresh bread.',10,0,2,'Easy',260,'labneh_plate.png'),

(5,'Foul Medames','Slow-cooked fava beans seasoned with garlic, lemon, and olive oil.',15,30,4,'Easy',310,'foul_medames.png'),

(5,'Cheese Regag','Thin Bahraini regag bread filled with melted cheese.',10,10,2,'Easy',350,'cheese_regag.png'),

(5,'Egg Regag','Traditional regag bread topped with freshly cooked eggs.',10,10,2,'Easy',330,'egg_regag.png');

INSERT INTO recipes
(category_id, recipe_name, description, prep_time, cook_time, servings, difficulty, calories, image)

VALUES

(6,'Luqaimat','Traditional Bahraini sweet dumplings drizzled with date syrup.',20,20,6,'Easy',380,'luqaimat.png'),

(6,'Khafaroosh','Sweet Bahraini fried cakes flavored with saffron and cardamom.',20,20,6,'Medium',420,'khafaroosh.png'),

(6,'Bahraini Halwa','Classic Bahraini halwa made with saffron, rose water, and nuts.',25,60,8,'Hard',450,'bahraini_halwa.png'),

(6,'Sago','Traditional sago pudding flavored with saffron and cardamom.',15,30,4,'Easy',290,'sago.png'),

(6,'Aseeda','Traditional sweet wheat pudding served warm with butter.',15,25,4,'Easy',340,'aseeda.png'),

(6,'Date Cake','Soft and moist cake made with sweet Bahraini dates.',20,45,8,'Medium',360,'date_cake.png'),

(6,'Umm Ali','Rich Middle Eastern bread pudding topped with nuts and raisins.',20,35,6,'Medium',410,'umm_ali.png'),

(6,'Rice Pudding','Creamy rice pudding flavored with cinnamon and cardamom.',15,40,4,'Easy',300,'rice_pudding.png'),

(6,'Sweet Vermicelli','Sweet roasted vermicelli cooked with sugar, butter, and nuts.',15,20,4,'Easy',330,'sweet_vermicelli.png'),

(6,'Coconut Cake','Soft coconut sponge cake topped with shredded coconut.',20,40,8,'Medium',390,'coconut_cake.png');

INSERT INTO recipes
(category_id, recipe_name, description, prep_time, cook_time, servings, difficulty, calories, image)

VALUES

(7,'Samosa','Crispy pastry filled with spiced vegetables and herbs.',20,15,4,'Easy',280,'samosa.png'),

(7,'Cheese Samosa','Golden fried samosas stuffed with melted cheese.',20,15,4,'Easy',320,'cheese_samosa.png'),

(7,'Meat Samosa','Crispy pastry filled with seasoned minced meat.',25,15,4,'Medium',350,'meat_samosa.png'),

(7,'Potato Cutlets','Crispy potato patties seasoned with herbs and spices.',20,15,4,'Easy',250,'potato_cutlets.png'),

(7,'Bahraini Kebab','Traditional Bahraini kebabs made with minced meat and aromatic spices.',25,20,4,'Medium',390,'bahraini_kebab.png'),

(7,'Meat Rolls','Crunchy rolls filled with seasoned minced meat.',25,15,4,'Medium',340,'meat_rolls.png'),

(7,'Stuffed Grape Leaves','Tender grape leaves stuffed with seasoned rice and herbs.',30,40,6,'Medium',220,'stuffed_grape_leaves.png'),

(7,'Spinach Fatayer','Baked pastries filled with seasoned spinach and onions.',25,20,6,'Medium',270,'spinach_fatayer.png');

INSERT INTO recipes
(category_id, recipe_name, description, prep_time, cook_time, servings, difficulty, calories, image)

VALUES

(8,'Karak Tea','Traditional spiced milk tea brewed with black tea, cardamom, and sugar.',5,10,2,'Easy',150,'karak_tea.png'),

(8,'Arabic Coffee','Traditional Arabic coffee flavored with cardamom and served with dates.',5,15,4,'Easy',25,'arabic_coffee.png'),

(8,'Lemon Mint Juice','Refreshing juice made with fresh lemons, mint leaves, and ice.',10,0,2,'Easy',120,'lemon_mint_juice.png'),

(8,'Tamarind Juice','Sweet and tangy tamarind drink served chilled.',15,10,4,'Easy',140,'tamarind_juice.png'),

(8,'Vimto Drink','Refreshing mixed fruit drink served cold, especially during Ramadan.',5,0,2,'Easy',180,'vimto_drink.png'),

(8,'Rose Milk','Chilled milk flavored with rose syrup and served over ice.',5,0,2,'Easy',190,'rose_milk.png'),

(8,'Date MilkShake','Creamy milkshake blended with fresh dates and milk.',10,0,2,'Easy',320,'date_milkshake.png'),

(8,'Saffron Milk','Warm milk infused with saffron, cardamom, and a touch of sugar.',5,10,2,'Easy',170,'saffron_milk.png');

INSERT INTO recipes
(category_id, recipe_name, description, prep_time, cook_time, servings, difficulty, calories, image)

VALUES

(9,'Salata Hara','Traditional Bahraini spicy salad made with tomatoes, cucumbers, onions, green chilies, fresh herbs, and lemon juice.',15,0,4,'Easy',120,'salata_hara.png'),

(9,'Salatat Khiyar wa Tamatim','Refreshing salad prepared with fresh cucumbers, tomatoes, onions, lemon juice, and herbs.',10,0,4,'Easy',90,'cucumber_tomato_salad.png'),

(9,'Tabbouleh','Fresh parsley salad with bulgur, tomatoes, mint, onions, olive oil, and lemon juice.',20,0,4,'Easy',180,'tabbouleh.png'),

(9,'Fattoush','Traditional Arabic mixed vegetable salad with crispy toasted pita bread and tangy dressing.',20,0,4,'Easy',210,'fattoush.png'),

(9,'Green Salad','Classic mixed green salad with lettuce, cucumbers, tomatoes, carrots, and lemon olive oil dressing.',10,0,4,'Easy',85,'green_salad.png');

INSERT INTO ingredients (ingredient_name)
VALUES
('Chicken'),
('Lamb'),
('Fish'),
('Rice'),
('Onion'),
('Tomato'),
('Garlic'),
('Ginger'),
('Machboos Spice'),
('Black Pepper'),
('Oil'),
('Sugar'),
('Date Syrup'),
('Cardamom'),
('Cinnamon'),
('Cloves'),
('Saffron'),
('Salt'),
('Butter'),
('Wheat'),
('Water'),
('Arabic Bread'),
('Turmeric'),
('Lemon Juice'),
('Cumin'),
('Raisins'),
('Almonds'),
('Yogurt'),
('Bay Leaf'),
('Coriander'),
('Potato'),
('Carrot'),
('Bell Pepper'),
('Tomato Paste'),
('Shark Meat'),
('Vermicelli'),
('Egg'),
('Rose Water'),
('Green Chili'),
('Hammour Fish'),
('Paprika'),
('Shrimp'),
('Kingfish'),
('Curry Powder'),
('Coconut Milk'),
('Flour'),
('Cornstarch'),
('Breadcrumbs'),
('Mixed Seafood'),
('Prawns'),
('Safi Fish'),
('Chili Flakes'),
('Red Lentils'),
('Chicken Stock'),
('Peas'),
('Celery'),
('Ground Cinnamon'),
('Fish Stock'),
('Parsley'),
('Yeast'),
('Milk'),
('Chickpeas'),
('Baking Powder'),
('Labneh'),
('Olives'),
('Olive Oil'),
('Mint Leaves'),
('Fava Beans'),
('Regag Bread'),
('Cheddar Cheese'),
('Nutmeg'),
('Corn Flour'),
('Rose Essence'),
('Mixed Nuts'),
('Sago Pearls'),
('Whole Wheat Flour'),
('Dates'),
('Vanilla Extract'),
('Puff Pastry'),
('Cream'),
('Pistachios'),
('Coconut'),
('Samosa Sheets'),
('Mozzarella Cheese'),
('Minced Beef'),
('Minced Lamb'),
('Spring Roll Sheets'),
('Grape Leaves'),
('Spinach'),
('Pastry Dough'),
('Black Tea'),
('Evaporated Milk'),
('Arabic Coffee'),
('Lemon'),
('Ice Cubes'),
('Tamarind'),
('Vimto Syrup'),
('Rose Syrup'),
('Cucumber'),
('Bulgur'),
('Lettuce'),
('Radish'),
('Sumac'),
('Pita Bread');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(1,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Chicken'),'1 kg'),
(1,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rice'),'3 cups'),
(1,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(1,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(1,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(1,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(1,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Machboos Spice'),'2 tbsp'),
(1,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(1,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(1,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(1,1,'Wash and season the chicken with spices.'),
(1,2,'Fry the onions until golden brown.'),
(1,3,'Add garlic, ginger, and tomatoes, then cook well.'),
(1,4,'Add the chicken and cook until tender.'),
(1,5,'Add the rice and enough water.'),
(1,6,'Cook until the rice is tender and serve hot.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(2,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lamb'),'1 kg'),
(2,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rice'),'3 cups'),
(2,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2'),
(2,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2'),
(2,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(2,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(2,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Machboos Spice'),'2 tbsp'),
(2,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(2,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(2,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');


INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(2,1,'Wash the lamb pieces thoroughly.'),
(2,2,'Cook lamb with spices until tender.'),
(2,3,'Fry onions until golden brown.'),
(2,4,'Add garlic, ginger, and tomatoes.'),
(2,5,'Mix lamb with rice and water.'),
(2,6,'Cook until rice is fully done and serve hot.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(3,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Fish'),'1 kg'),
(3,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rice'),'3 cups'),
(3,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2'),
(3,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2'),
(3,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(3,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(3,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Machboos Spice'),'2 tbsp'),
(3,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(3,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(3,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(3,1,'Clean and prepare the fish properly.'),
(3,2,'Season fish with salt and spices.'),
(3,3,'Fry onions until golden brown.'),
(3,4,'Add garlic, ginger, and tomatoes.'),
(3,5,'Cook fish lightly in the spice mixture.'),
(3,6,'Add rice and water, then cook until done.'),
(3,7,'Serve hot with lemon and salad.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(4,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rice'),'3 cups'),
(4,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'3 tbsp'),
(4,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Date Syrup'),'2 tbsp'),
(4,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cardamom'),'1 tsp'),
(4,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Saffron'),'1 pinch'),
(4,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(4,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(4,1,'Wash the rice thoroughly.'),
(4,2,'Soak saffron in warm water.'),
(4,3,'Cook rice with sugar and salt.'),
(4,4,'Add cardamom and saffron mixture.'),
(4,5,'Mix in date syrup for sweetness.'),
(4,6,'Add butter for rich flavor.'),
(4,7,'Cook until rice is soft and fragrant.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(5,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lamb'),'1.5 kg'),
(5,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rice'),'3 cups'),
(5,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(5,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(5,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(5,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(5,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cardamom'),'4 pods'),
(5,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cinnamon'),'1 tsp'),
(5,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cloves'),'3 pieces'),
(5,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(5,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(5,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(5,1,'Wash and clean the lamb pieces.'),
(5,2,'Cook lamb with spices until tender.'),
(5,3,'Fry onions until golden brown.'),
(5,4,'Add garlic, ginger, and tomatoes.'),
(5,5,'Add cardamom, cinnamon, and cloves.'),
(5,6,'Add rice and water, then mix well.'),
(5,7,'Slow cook until rice is fully done.'),
(5,8,'Serve hot with salad or yogurt.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(6,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Wheat'),'2 cups'),
(6,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lamb'),'500 g'),
(6,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'6 cups'),
(6,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(6,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(6,1,'Wash the wheat thoroughly and soak it overnight.'),
(6,2,'Add meat (lamb or chicken) to a pot with water.'),
(6,3,'Cook on low heat until meat becomes soft.'),
(6,4,'Add soaked wheat to the pot.'),
(6,5,'Stir continuously to avoid lumps.'),
(6,6,'Cook slowly until mixture becomes creamy.'),
(6,7,'Add salt and butter for flavor.'),
(6,8,'Serve hot with cinnamon on top.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(7,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lamb'),'1 kg'),
(7,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(7,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(7,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(7,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(7,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(7,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(7,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp'),
(7,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Arabic Bread'),'4 pieces');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(7,1,'Cut the lamb into medium-sized pieces and wash thoroughly.'),
(7,2,'Cook the lamb until tender.'),
(7,3,'Fry the onion until golden, then add garlic and ginger.'),
(7,4,'Add tomatoes and cook until soft.'),
(7,5,'Return the lamb to the pot and season with salt and black pepper.'),
(7,6,'Simmer until the stew thickens.'),
(7,7,'Place pieces of Arabic bread in a serving dish and pour the stew over the bread.'),
(7,8,'Serve hot.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(8,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Chicken'),'1 kg'),
(8,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rice'),'2 cups'),
(8,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(8,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(8,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(8,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Turmeric'),'1 tsp'),
(8,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(8,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(8,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(8,1,'Wash and cut the chicken into medium pieces.'),
(8,2,'Heat oil and sauté the onion until golden.'),
(8,3,'Add garlic, ginger, and turmeric, then cook for 2 minutes.'),
(8,4,'Add the chicken and cook until lightly browned.'),
(8,5,'Add the rice and enough water to cover the ingredients.'),
(8,6,'Cook until the chicken and rice are very tender.'),
(8,7,'Mash and stir the mixture until it becomes creamy.'),
(8,8,'Serve hot with melted butter if desired.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(9,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Fish'),'1 kg'),
(9,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rice'),'2 cups'),
(9,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(9,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(9,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(9,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Turmeric'),'1 tsp'),
(9,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(9,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(9,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(9,1,'Clean and cut the fish into medium-sized pieces.'),
(9,2,'Heat oil and sauté the onion until soft.'),
(9,3,'Add garlic, ginger, and turmeric, then cook for 2 minutes.'),
(9,4,'Add the fish and cook gently for a few minutes.'),
(9,5,'Add the rice and enough water to cover the ingredients.'),
(9,6,'Cook until the fish and rice are very soft.'),
(9,7,'Stir and mash the mixture until it becomes creamy.'),
(9,8,'Serve hot with melted butter if desired.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(10,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Fish'),'1 whole'),
(10,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(10,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(10,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lemon Juice'),'2 tbsp'),
(10,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(10,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(10,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(10,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(10,1,'Clean and wash the fish thoroughly.'),
(10,2,'Mix garlic, ginger, lemon juice, cumin, salt, and black pepper to make a marinade.'),
(10,3,'Coat the fish evenly with the marinade.'),
(10,4,'Let the fish marinate for 30 minutes.'),
(10,5,'Brush the fish lightly with oil.'),
(10,6,'Grill the fish over medium heat until cooked on both sides.'),
(10,7,'Serve hot with rice, salad, and lemon wedges.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(11,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Chicken'),'1 kg'),
(11,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rice'),'3 cups'),
(11,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(11,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(11,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(11,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cardamom'),'4 pods'),
(11,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cinnamon'),'1 stick'),
(11,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cloves'),'4 pieces'),
(11,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Raisins'),'1/4 cup'),
(11,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Almonds'),'1/4 cup'),
(11,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(11,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(11,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(11,1,'Wash and season the chicken with salt and spices.'),
(11,2,'Cook the chicken until tender and set aside.'),
(11,3,'Fry the onions until golden, then add garlic and ginger.'),
(11,4,'Add cardamom, cinnamon, and cloves and cook briefly.'),
(11,5,'Add the rice and pour in enough water or chicken stock.'),
(11,6,'Cook until the rice is almost done.'),
(11,7,'Top with cooked chicken, raisins, and almonds.'),
(11,8,'Cover and cook on low heat until the rice is fully cooked.'),
(11,9,'Serve hot.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(12,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Chicken'),'1 kg'),
(12,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rice'),'3 cups'),
(12,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(12,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(12,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(12,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(12,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Yogurt'),'1 cup'),
(12,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Turmeric'),'1 tsp'),
(12,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cardamom'),'4 pods'),
(12,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cinnamon'),'1 stick'),
(12,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cloves'),'4 pieces'),
(12,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Bay Leaf'),'2 leaves'),
(12,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Saffron'),'1 pinch'),
(12,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(12,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(12,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp'),
(12,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Coriander'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(12,1,'Wash and marinate the chicken with yogurt, turmeric, salt, and black pepper for 30 minutes.'),
(12,2,'Heat oil and fry the onions until golden brown.'),
(12,3,'Add garlic, ginger, tomatoes, and whole spices, then cook well.'),
(12,4,'Add the marinated chicken and cook until tender.'),
(12,5,'Cook the rice until it is partially done.'),
(12,6,'Layer the rice over the chicken mixture.'),
(12,7,'Sprinkle saffron water and chopped coriander over the rice.'),
(12,8,'Cover and cook on low heat until the rice is fully cooked.'),
(12,9,'Serve hot with salad or yogurt.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(13,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Chicken'),'1 kg'),
(13,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(13,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(13,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(13,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(13,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Potato'),'2 medium'),
(13,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Carrot'),'2 medium'),
(13,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Bell Pepper'),'1 medium'),
(13,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato Paste'),'2 tbsp'),
(13,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(13,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Coriander'),'2 tbsp'),
(13,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(13,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(13,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(13,1,'Cut the chicken into medium-sized pieces and wash thoroughly.'),
(13,2,'Heat oil and fry the onions until soft.'),
(13,3,'Add garlic and ginger, then cook for 2 minutes.'),
(13,4,'Add tomatoes and tomato paste, then cook until combined.'),
(13,5,'Add the chicken and cook until lightly browned.'),
(13,6,'Add potato, carrot, and bell pepper.'),
(13,7,'Season with cumin, coriander, salt, and black pepper.'),
(13,8,'Add water and simmer until the chicken and vegetables are tender.'),
(13,9,'Serve hot with rice or fresh bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(14,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lamb'),'1 kg'),
(14,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(14,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(14,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(14,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(14,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Potato'),'2 medium'),
(14,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Carrot'),'2 medium'),
(14,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Bell Pepper'),'1 medium'),
(14,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato Paste'),'2 tbsp'),
(14,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(14,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Coriander'),'2 tbsp'),
(14,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(14,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(14,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(14,1,'Wash and cut the lamb into medium-sized pieces.'),
(14,2,'Heat oil and fry the onions until golden.'),
(14,3,'Add garlic and ginger, then cook for 2 minutes.'),
(14,4,'Add tomatoes and tomato paste and cook until soft.'),
(14,5,'Add the lamb and cook until browned.'),
(14,6,'Add potato, carrot, and bell pepper.'),
(14,7,'Season with cumin, coriander, salt, and black pepper.'),
(14,8,'Add water and simmer until the lamb becomes tender.'),
(14,9,'Serve hot with rice or fresh bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(15,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Potato'),'2 medium'),
(15,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Carrot'),'2 medium'),
(15,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Bell Pepper'),'1 medium'),
(15,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(15,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(15,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(15,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(15,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato Paste'),'2 tbsp'),
(15,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(15,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Coriander'),'2 tbsp'),
(15,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(15,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(15,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(15,1,'Wash and chop all the vegetables into medium-sized pieces.'),
(15,2,'Heat oil and fry the onions until soft.'),
(15,3,'Add garlic and ginger, then cook for 2 minutes.'),
(15,4,'Add tomatoes and tomato paste and cook until softened.'),
(15,5,'Add potato, carrot, and bell pepper.'),
(15,6,'Season with cumin, coriander, salt, and black pepper.'),
(15,7,'Add enough water and simmer until the vegetables are tender.'),
(15,8,'Serve hot with rice or fresh bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(16,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Shark Meat'),'1 kg'),
(16,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(16,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(16,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(16,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(16,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Turmeric'),'1 tsp'),
(16,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(16,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Coriander'),'2 tbsp'),
(16,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(16,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(16,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(16,1,'Wash the shark meat thoroughly and cut it into medium-sized pieces.'),
(16,2,'Boil the shark meat until cooked, then drain and shred it.'),
(16,3,'Heat oil and sauté the onion until golden brown.'),
(16,4,'Add garlic, ginger, and tomatoes, then cook until softened.'),
(16,5,'Add turmeric, cumin, coriander, salt, and black pepper.'),
(16,6,'Mix in the shredded shark meat and cook for 10–15 minutes.'),
(16,7,'Stir well until the flavors are combined.'),
(16,8,'Serve hot with Bahraini rice or Arabic bread.');


INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(17,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Kingfish'),'1 whole'),
(17,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(17,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(17,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lemon Juice'),'2 tbsp'),
(17,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Paprika'),'1 tsp'),
(17,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(17,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(17,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(17,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(17,1,'Clean and wash the kingfish thoroughly.'),
(17,2,'Prepare a marinade using garlic, ginger, lemon juice, paprika, cumin, salt, and black pepper.'),
(17,3,'Coat the fish evenly with the marinade and let it rest for 30 minutes.'),
(17,4,'Brush the fish lightly with oil.'),
(17,5,'Grill the fish over medium heat for 6–8 minutes on each side until fully cooked.'),
(17,6,'Serve hot with rice, grilled vegetables, or salad.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Shrimp'),'500 g'),
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'3 cloves'),
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Green Chili'),'1'),
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Curry Powder'),'2 tbsp'),
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Coconut Milk'),'1 cup'),
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(18,1,'Clean and devein the shrimp thoroughly.'),
(18,2,'Heat the oil and sauté the onion until soft.'),
(18,3,'Add garlic, ginger, and green chili, then cook for 2 minutes.'),
(18,4,'Add the tomatoes and curry powder, then cook until the tomatoes soften.'),
(18,5,'Pour in the coconut milk and stir well.'),
(18,6,'Add the shrimp and cook for 5–7 minutes until pink and fully cooked.'),
(18,7,'Season with salt and black pepper.'),
(18,8,'Serve hot with steamed rice.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(19,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Shrimp'),'500 g'),
(19,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Flour'),'1 cup'),
(19,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cornstarch'),'1/2 cup'),
(19,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Egg'),'2'),
(19,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Breadcrumbs'),'1 cup'),
(19,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(19,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(19,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'500 ml');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(19,1,'Clean and devein the shrimp thoroughly.'),
(19,2,'Season the shrimp with salt and black pepper.'),
(19,3,'Coat each shrimp with flour.'),
(19,4,'Dip the shrimp into the beaten eggs.'),
(19,5,'Cover the shrimp evenly with breadcrumbs.'),
(19,6,'Heat the oil in a deep frying pan.'),
(19,7,'Fry the shrimp until golden brown and crispy.'),
(19,8,'Drain on paper towels and serve hot with dipping sauce.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Fish'),'1 kg'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Green Chili'),'1'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Curry Powder'),'2 tbsp'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Coconut Milk'),'1 cup'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(20,1,'Clean and cut the fish into medium-sized pieces.'),
(20,2,'Heat the oil and sauté the onion until soft.'),
(20,3,'Add garlic, ginger, and green chili, then cook for 2 minutes.'),
(20,4,'Add tomatoes and curry powder, then cook until the tomatoes soften.'),
(20,5,'Pour in the coconut milk and stir well.'),
(20,6,'Add the fish and simmer gently for 10–12 minutes until cooked.'),
(20,7,'Season with salt and black pepper.'),
(20,8,'Serve hot with steamed rice or bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Fish'),'1 kg'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Green Chili'),'1'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Curry Powder'),'2 tbsp'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Coconut Milk'),'1 cup'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(21,1,'Clean and cut the fish into medium-sized pieces.'),
(21,2,'Heat the oil and sauté the onion until soft.'),
(21,3,'Add garlic, ginger, and green chili, then cook for 2 minutes.'),
(21,4,'Add tomatoes and curry powder and cook until the tomatoes soften.'),
(21,5,'Pour in the coconut milk and stir well.'),
(21,6,'Add the fish and simmer gently for 10 to 12 minutes until fully cooked.'),
(21,7,'Season with salt and black pepper to taste.'),
(21,8,'Serve hot with steamed rice or Arabic bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Mixed Seafood'),'1 kg'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Potato'),'2 medium'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Carrot'),'2 medium'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Bell Pepper'),'1 medium'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato Paste'),'2 tbsp'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Coriander'),'2 tbsp'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(22,1,'Clean and prepare the mixed seafood.'),
(22,2,'Heat the oil and sauté the onions until soft.'),
(22,3,'Add garlic and ginger, then cook for 2 minutes.'),
(22,4,'Add tomatoes and tomato paste, then cook until softened.'),
(22,5,'Add potato, carrot, and bell pepper.'),
(22,6,'Season with cumin, coriander, salt, and black pepper.'),
(22,7,'Add the mixed seafood and enough water, then simmer until the vegetables are tender and the seafood is cooked.'),
(22,8,'Serve hot with rice or Arabic bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Prawns'),'500 g'),
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rice'),'3 cups'),
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Turmeric'),'1 tsp'),
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(23,1,'Clean and devein the prawns thoroughly.'),
(23,2,'Heat the oil and fry the onions until golden brown.'),
(23,3,'Add garlic, ginger, and tomatoes, then cook until softened.'),
(23,4,'Add turmeric, salt, and black pepper, then mix well.'),
(23,5,'Add the prawns and cook for 3 to 4 minutes.'),
(23,6,'Add the rice and enough water, then stir well.'),
(23,7,'Cook until the rice is tender and the liquid is absorbed.'),
(23,8,'Serve hot with salad and lemon wedges.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Safi Fish'),'1 whole'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Turmeric'),'1 tsp'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Paprika'),'1 tsp'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lemon Juice'),'2 tbsp'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(24,1,'Clean and wash the Safi fish thoroughly.'),
(24,2,'Prepare a marinade using garlic, ginger, turmeric, paprika, lemon juice, salt, and black pepper.'),
(24,3,'Coat the fish evenly with the marinade and let it rest for 30 minutes.'),
(24,4,'Heat the oil in a frying pan.'),
(24,5,'Fry the fish on both sides until golden brown and fully cooked.'),
(24,6,'Drain excess oil and serve hot with rice, salad, and lemon wedges.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Fish'),'1 kg'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Potato'),'2 medium'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Carrot'),'1 medium'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato Paste'),'2 tbsp'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Coriander'),'1 tbsp'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(25,1,'Clean and cut the fish into medium-sized pieces.'),
(25,2,'Heat the oil and sauté the onions until soft.'),
(25,3,'Add garlic, ginger, tomatoes, and tomato paste, then cook well.'),
(25,4,'Add the potato and carrot and stir for a few minutes.'),
(25,5,'Season with cumin, coriander, salt, and black pepper.'),
(25,6,'Add enough water and simmer until the vegetables are almost tender.'),
(25,7,'Add the fish and cook gently until fully cooked.'),
(25,8,'Serve hot with rice or fresh bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Shrimp'),'500 g'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'5 cloves'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Green Chili'),'2'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Chili Flakes'),'1 tsp'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Paprika'),'1 tsp'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lemon Juice'),'2 tbsp'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(26,1,'Clean and devein the shrimp thoroughly.'),
(26,2,'Season the shrimp with salt, black pepper, paprika, and lemon juice.'),
(26,3,'Heat the oil in a frying pan.'),
(26,4,'Sauté the garlic, ginger, and green chili until fragrant.'),
(26,5,'Add the shrimp and cook for 3 to 5 minutes.'),
(26,6,'Sprinkle the chili flakes and stir well.'),
(26,7,'Cook until the shrimp are fully cooked and coated with the spices.'),
(26,8,'Serve hot with rice, bread, or a fresh salad.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Red Lentils'),'2 cups'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'3 cloves'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Turmeric'),'1/2 tsp'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'5 cups');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(27,1,'Wash the red lentils thoroughly.'),
(27,2,'Heat the oil and sauté the onion until soft.'),
(27,3,'Add garlic, ginger, and tomatoes, then cook until softened.'),
(27,4,'Add the red lentils, cumin, turmeric, salt, and black pepper.'),
(27,5,'Pour in the water and bring to a boil.'),
(27,6,'Reduce the heat and simmer until the lentils are tender.'),
(27,7,'Blend the soup until smooth if desired.'),
(27,8,'Serve hot with lemon wedges or fresh bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Chicken'),'500 g'),
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'3 cloves'),
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Carrot'),'1 medium'),
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Chicken Stock'),'4 cups'),
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Bay Leaf'),'1'),
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'1 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(28,1,'Cut the chicken into small pieces.'),
(28,2,'Heat the oil and sauté the onion until soft.'),
(28,3,'Add the garlic and ginger, then cook for 2 minutes.'),
(28,4,'Add the chicken and cook until lightly browned.'),
(28,5,'Add the carrot, chicken stock, and bay leaf.'),
(28,6,'Season with salt and black pepper.'),
(28,7,'Simmer for 30 minutes until the chicken is tender.'),
(28,8,'Serve hot with fresh bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Carrot'),'2 medium'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Potato'),'2 medium'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Peas'),'1 cup'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Celery'),'2 stalks'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'3 cloves'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'5 cups');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(29,1,'Wash and chop all the vegetables into small pieces.'),
(29,2,'Heat the oil and sauté the onion until soft.'),
(29,3,'Add the garlic and ginger, then cook for 2 minutes.'),
(29,4,'Add the tomatoes, carrots, potatoes, peas, and celery.'),
(29,5,'Season with salt and black pepper.'),
(29,6,'Pour in the water and bring to a boil.'),
(29,7,'Simmer for 25 to 30 minutes until the vegetables are tender.'),
(29,8,'Serve hot with fresh bread or crackers.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Chicken'),'500 g'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Wheat'),'1 cup'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'3 cloves'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Chicken Stock'),'5 cups'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ground Cinnamon'),'1/2 tsp'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'1 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(30,1,'Wash the wheat and soak it for at least 2 hours.'),
(30,2,'Cook the chicken until tender, then shred it into small pieces.'),
(30,3,'Heat butter and sauté the onion, garlic, and ginger.'),
(30,4,'Add the soaked wheat and chicken stock.'),
(30,5,'Add the shredded chicken, salt, black pepper, and ground cinnamon.'),
(30,6,'Simmer on low heat until the wheat becomes very soft.'),
(30,7,'Stir continuously until the soup reaches a smooth and creamy consistency.'),
(30,8,'Serve hot with a sprinkle of cinnamon if desired.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Mixed Seafood'),'500 g'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'3 cloves'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Fish Stock'),'4 cups'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Parsley'),'2 tbsp'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(31,1,'Clean and prepare the mixed seafood.'),
(31,2,'Heat the oil and sauté the onion until soft.'),
(31,3,'Add the garlic, ginger, and tomatoes, then cook until softened.'),
(31,4,'Pour in the fish stock and bring it to a boil.'),
(31,5,'Add the mixed seafood and cook for 8 to 10 minutes.'),
(31,6,'Season with salt and black pepper.'),
(31,7,'Stir in the chopped parsley and simmer for 2 minutes.'),
(31,8,'Serve hot with lemon wedges and fresh bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(32,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Flour'),'4 cups'),
(32,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Yeast'),'1 tbsp'),
(32,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(32,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'1½ cups'),
(32,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(32,1,'Mix the flour, yeast, and salt in a large bowl.'),
(32,2,'Gradually add the water and knead into a smooth dough.'),
(32,3,'Add the oil and continue kneading until the dough is soft.'),
(32,4,'Cover the dough and let it rise for 1 hour.'),
(32,5,'Divide the dough into equal portions and flatten into round breads.'),
(32,6,'Bake in a preheated oven until golden brown.'),
(32,7,'Remove from the oven and brush lightly with oil if desired.'),
(32,8,'Serve warm with curries, soups, or breakfast dishes.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(33,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Flour'),'4 cups'),
(33,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Yeast'),'1 tbsp'),
(33,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(33,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'1½ cups'),
(33,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(33,1,'Mix the flour, yeast, and salt in a large bowl.'),
(33,2,'Gradually add water and knead until a smooth dough forms.'),
(33,3,'Add the oil and continue kneading for 8 to 10 minutes.'),
(33,4,'Cover the dough and let it rise for about 1 hour.'),
(33,5,'Divide the dough into equal portions and flatten each into a round shape.'),
(33,6,'Bake in a hot tannour oven until the bread is golden and slightly crisp.'),
(33,7,'Remove the bread carefully and allow it to cool slightly.'),
(33,8,'Serve warm with curries, grilled meat, or traditional Bahraini dishes.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(34,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Flour'),'2 cups'),
(34,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'2 cups'),
(34,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1/2 tsp'),
(34,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'1 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(34,1,'Mix the flour, water, salt, and oil into a smooth batter.'),
(34,2,'Heat a flat griddle over medium heat.'),
(34,3,'Pour a thin layer of batter onto the hot griddle.'),
(34,4,'Spread the batter evenly into a thin round shape.'),
(34,5,'Cook until the edges become crisp and the bread is fully cooked.'),
(34,6,'Carefully remove the bread from the griddle.'),
(34,7,'Repeat with the remaining batter.'),
(34,8,'Serve warm with cheese, honey, or traditional Bahraini dishes.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Flour'),'4 cups'),
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Yeast'),'1 tbsp'),
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Milk'),'1 cup'),
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'2 tbsp'),
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cardamom'),'1 tsp'),
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Saffron'),'1 pinch'),
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'2 tbsp'),
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1/2 tsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(35,1,'Mix the flour, yeast, sugar, and salt in a large bowl.'),
(35,2,'Add the warm milk, butter, cardamom, and saffron, then knead into a soft dough.'),
(35,3,'Cover the dough and let it rise for about 1 hour.'),
(35,4,'Divide the dough into equal portions and shape into small round breads.'),
(35,5,'Place the dough on a baking tray and let it rest for 15 minutes.'),
(35,6,'Bake in a preheated oven until golden brown.'),
(35,7,'Brush with melted butter after baking for a soft texture.'),
(35,8,'Serve warm with tea or as a breakfast bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(36,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Flour'),'2 cups'),
(36,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Yeast'),'1 tsp'),
(36,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Milk'),'1 cup'),
(36,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Egg'),'1'),
(36,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'1 tbsp'),
(36,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cardamom'),'1 tsp'),
(36,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Saffron'),'1 pinch'),
(36,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'2 tbsp'),
(36,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1/4 tsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(36,1,'Mix the flour, yeast, sugar, and salt in a bowl.'),
(36,2,'Add the milk, egg, cardamom, and saffron, then whisk into a smooth batter.'),
(36,3,'Cover the batter and let it rest for about 1 hour.'),
(36,4,'Heat a lightly buttered non-stick pan over medium heat.'),
(36,5,'Pour a ladle of batter onto the pan to form a round pancake.'),
(36,6,'Cook until bubbles appear, then flip and cook the other side until golden brown.'),
(36,7,'Repeat with the remaining batter.'),
(36,8,'Serve warm with honey, date syrup, or cream.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(37,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Vermicelli'),'250 g'),
(37,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'1/4 cup'),
(37,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'2 tbsp'),
(37,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cardamom'),'1 tsp'),
(37,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Saffron'),'1 pinch'),
(37,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rose Water'),'1 tsp'),
(37,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Egg'),'3'),
(37,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1/2 tsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(37,1,'Cook the vermicelli until tender and drain well.'),
(37,2,'Melt the butter in a pan and stir in the sugar.'),
(37,3,'Add the vermicelli along with cardamom, saffron, and rose water.'),
(37,4,'Cook for a few minutes until the flavors are well combined.'),
(37,5,'Beat the eggs with a pinch of salt.'),
(37,6,'Cook the eggs into a thin omelet in a separate pan.'),
(37,7,'Place the omelet over the sweet vermicelli.'),
(37,8,'Serve warm for breakfast.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(38,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Egg'),'3'),
(38,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(38,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Green Chili'),'1'),
(38,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1/2 tsp'),
(38,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/4 tsp'),
(38,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'1 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(38,1,'Heat the oil in a frying pan over medium heat.'),
(38,2,'Add the chopped tomatoes and green chili, then cook until softened.'),
(38,3,'Season with salt and black pepper.'),
(38,4,'Beat the eggs in a bowl.'),
(38,5,'Pour the eggs over the tomato mixture.'),
(38,6,'Cook gently until the eggs are set.'),
(38,7,'Fold the mixture lightly and cook for another minute.'),
(38,8,'Serve hot with fresh Khubz or Regag bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(39,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Chickpeas'),'2 cups'),
(39,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(39,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'3 cloves'),
(39,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Parsley'),'1/2 cup'),
(39,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Coriander'),'1/4 cup'),
(39,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(39,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(39,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(39,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Baking Powder'),'1 tsp'),
(39,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'As needed for frying');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(39,1,'Soak the chickpeas overnight and drain well.'),
(39,2,'Blend the chickpeas with onion, garlic, parsley, and coriander.'),
(39,3,'Add cumin, salt, black pepper, and baking powder, then mix well.'),
(39,4,'Shape the mixture into small balls or patties.'),
(39,5,'Heat the oil in a deep pan.'),
(39,6,'Fry the falafel until golden brown and crispy.'),
(39,7,'Drain on paper towels to remove excess oil.'),
(39,8,'Serve hot with tahini sauce, salad, and Khubz bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(40,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Labneh'),'250 g'),
(40,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Olive Oil'),'2 tbsp'),
(40,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Olives'),'8 pieces'),
(40,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Mint Leaves'),'1 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(40,1,'Spread the labneh evenly on a serving plate.'),
(40,2,'Drizzle the olive oil over the labneh.'),
(40,3,'Arrange the olives around the labneh.'),
(40,4,'Garnish with fresh mint leaves.'),
(40,5,'Chill for a few minutes before serving if desired.'),
(40,6,'Serve with warm Khubz or Regag bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(41,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Fava Beans'),'2 cups'),
(41,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'3 cloves'),
(41,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lemon Juice'),'2 tbsp'),
(41,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Olive Oil'),'2 tbsp'),
(41,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Parsley'),'2 tbsp'),
(41,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(41,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(41,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(41,1,'Cook the fava beans until they are soft.'),
(41,2,'Mash the beans lightly with a spoon or fork.'),
(41,3,'Add the garlic, cumin, salt, and black pepper.'),
(41,4,'Stir in the lemon juice and olive oil.'),
(41,5,'Cook for 5 minutes over low heat while stirring.'),
(41,6,'Transfer the foul to a serving bowl.'),
(41,7,'Garnish with chopped parsley and a drizzle of olive oil.'),
(41,8,'Serve hot with Khubz or Regag bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(42,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Regag Bread'),'1 piece'),
(42,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cheddar Cheese'),'100 g'),
(42,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'1 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(42,1,'Heat a flat pan over medium heat.'),
(42,2,'Place the Regag bread on the pan.'),
(42,3,'Spread the butter evenly over the bread.'),
(42,4,'Sprinkle the cheddar cheese evenly on top.'),
(42,5,'Fold the bread in half.'),
(42,6,'Cook until the cheese melts completely.'),
(42,7,'Remove from the pan and cut into pieces if desired.'),
(42,8,'Serve hot as a traditional Bahraini breakfast.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(43,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Regag Bread'),'1 piece'),
(43,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Egg'),'2'),
(43,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'1 tbsp'),
(43,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1/4 tsp'),
(43,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/4 tsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(43,1,'Heat a flat pan over medium heat.'),
(43,2,'Place the Regag bread on the pan and spread the butter evenly.'),
(43,3,'Crack the eggs directly onto the bread.'),
(43,4,'Season with salt and black pepper.'),
(43,5,'Spread the eggs evenly over the bread.'),
(43,6,'Cook until the eggs are fully set.'),
(43,7,'Fold the bread if desired and cook for another minute.'),
(43,8,'Serve hot as a traditional Bahraini breakfast.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(44,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Flour'),'2 cups'),
(44,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cornstarch'),'2 tbsp'),
(44,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Yeast'),'1 tsp'),
(44,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Baking Powder'),'1 tsp'),
(44,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'1 tbsp'),
(44,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'1½ cups'),
(44,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'As needed for frying'),
(44,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Date Syrup'),'1/2 cup');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(44,1,'Mix the flour, cornstarch, yeast, baking powder, and sugar in a bowl.'),
(44,2,'Gradually add the water and mix into a smooth batter.'),
(44,3,'Cover the batter and let it rest for 1 hour.'),
(44,4,'Heat the oil in a deep frying pan.'),
(44,5,'Drop small portions of the batter into the hot oil.'),
(44,6,'Fry until the luqaimat are golden brown and crispy.'),
(44,7,'Drain on paper towels to remove excess oil.'),
(44,8,'Drizzle generously with date syrup and serve warm.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(45,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Flour'),'2 cups'),
(45,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Egg'),'2'),
(45,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'1/2 cup'),
(45,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cardamom'),'1 tsp'),
(45,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Saffron'),'1 pinch'),
(45,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rose Water'),'1 tbsp'),
(45,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Nutmeg'),'1/4 tsp'),
(45,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Baking Powder'),'1 tsp'),
(45,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'2 tbsp'),
(45,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'As needed for frying');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(45,1,'Mix the flour, sugar, baking powder, and nutmeg in a bowl.'),
(45,2,'Add the eggs, melted butter, rose water, cardamom, and saffron.'),
(45,3,'Mix until a smooth batter is formed.'),
(45,4,'Heat the oil in a deep frying pan.'),
(45,5,'Drop spoonfuls of the batter into the hot oil.'),
(45,6,'Fry until golden brown on both sides.'),
(45,7,'Drain on paper towels to remove excess oil.'),
(45,8,'Serve warm with tea or coffee.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(46,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Corn Flour'),'1 cup'),
(46,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'2 cups'),
(46,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'4 cups'),
(46,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cardamom'),'1 tsp'),
(46,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Saffron'),'1 pinch'),
(46,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rose Water'),'2 tbsp'),
(46,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rose Essence'),'1 tsp'),
(46,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'2 tbsp'),
(46,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Mixed Nuts'),'1/2 cup');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(46,1,'Mix the corn flour with water until smooth.'),
(46,2,'Heat the mixture over medium heat while stirring continuously.'),
(46,3,'Add the sugar and continue stirring until dissolved.'),
(46,4,'Mix in the butter, saffron, cardamom, rose water, and rose essence.'),
(46,5,'Cook until the mixture becomes thick and glossy.'),
(46,6,'Stir in half of the mixed nuts.'),
(46,7,'Pour the halwa into a serving dish and garnish with the remaining nuts.'),
(46,8,'Allow it to cool slightly before serving.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(47,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sago Pearls'),'1 cup'),
(47,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'1 cup'),
(47,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'4 cups'),
(47,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cardamom'),'1 tsp'),
(47,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Saffron'),'1 pinch'),
(47,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rose Water'),'1 tbsp'),
(47,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'1 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(47,1,'Wash the sago pearls thoroughly.'),
(47,2,'Boil the water and add the sago pearls.'),
(47,3,'Cook until the sago becomes soft and translucent.'),
(47,4,'Add the sugar and stir until completely dissolved.'),
(47,5,'Mix in the cardamom, saffron, and rose water.'),
(47,6,'Stir in the butter until melted.'),
(47,7,'Cook for another 5 minutes until slightly thickened.'),
(47,8,'Serve warm or chilled as desired.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(48,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Whole Wheat Flour'),'2 cups'),
(48,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'4 cups'),
(48,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'3 tbsp'),
(48,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'1/2 cup'),
(48,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cardamom'),'1 tsp'),
(48,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Saffron'),'1 pinch'),
(48,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1/4 tsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(48,1,'Bring the water to a boil in a large pot.'),
(48,2,'Gradually add the whole wheat flour while stirring continuously.'),
(48,3,'Cook over low heat until the mixture becomes thick and smooth.'),
(48,4,'Add the sugar, butter, cardamom, saffron, and salt.'),
(48,5,'Continue stirring until all the ingredients are well combined.'),
(48,6,'Cook for another 5 to 10 minutes until creamy.'),
(48,7,'Transfer to a serving dish.'),
(48,8,'Serve warm with extra melted butter if desired.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(49,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Dates'),'2 cups'),
(49,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Flour'),'2 cups'),
(49,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Egg'),'2'),
(49,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'1/2 cup'),
(49,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'1/2 cup'),
(49,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Milk'),'1 cup'),
(49,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Baking Powder'),'2 tsp'),
(49,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Vanilla Extract'),'1 tsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(49,1,'Preheat the oven to 180°C.'),
(49,2,'Blend the dates with the milk until smooth.'),
(49,3,'Mix the flour and baking powder in a bowl.'),
(49,4,'Add the eggs, butter, sugar, vanilla extract, and date mixture.'),
(49,5,'Mix until a smooth batter forms.'),
(49,6,'Pour the batter into a greased cake tin.'),
(49,7,'Bake for 35 to 40 minutes or until a toothpick comes out clean.'),
(49,8,'Allow the cake to cool before slicing and serving.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(50,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Puff Pastry'),'250 g'),
(50,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Milk'),'2 cups'),
(50,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cream'),'1 cup'),
(50,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'1/2 cup'),
(50,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'2 tbsp'),
(50,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Raisins'),'1/4 cup'),
(50,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Almonds'),'1/4 cup'),
(50,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Pistachios'),'1/4 cup'),
(50,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Vanilla Extract'),'1 tsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(50,1,'Preheat the oven to 180°C.'),
(50,2,'Break the baked puff pastry into small pieces and place them in a baking dish.'),
(50,3,'Sprinkle the raisins, almonds, and pistachios over the pastry.'),
(50,4,'Heat the milk, cream, sugar, butter, and vanilla extract until the sugar dissolves.'),
(50,5,'Pour the warm milk mixture evenly over the pastry.'),
(50,6,'Bake for 20 to 25 minutes until the top is golden brown.'),
(50,7,'Allow it to cool slightly before serving.'),
(50,8,'Serve warm, garnished with extra nuts if desired.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(51,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rice'),'1 cup'),
(51,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Milk'),'4 cups'),
(51,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'1/2 cup'),
(51,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cardamom'),'1 tsp'),
(51,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Saffron'),'1 pinch'),
(51,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Vanilla Extract'),'1 tsp'),
(51,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'1 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(51,1,'Wash the rice thoroughly.'),
(51,2,'Cook the rice with the milk over medium heat.'),
(51,3,'Stir frequently until the rice becomes soft and creamy.'),
(51,4,'Add the sugar, cardamom, saffron, and vanilla extract.'),
(51,5,'Mix well and continue cooking for 5 to 10 minutes.'),
(51,6,'Stir in the butter until melted.'),
(51,7,'Transfer the pudding to serving bowls.'),
(51,8,'Serve warm or chilled, garnished with cinnamon or chopped nuts if desired.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(52,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Vermicelli'),'250 g'),
(52,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'2 tbsp'),
(52,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'1/2 cup'),
(52,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cardamom'),'1 tsp'),
(52,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Saffron'),'1 pinch'),
(52,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'1 cup'),
(52,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Mixed Nuts'),'1/4 cup');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(52,1,'Melt the butter in a pan over medium heat.'),
(52,2,'Add the vermicelli and roast until golden brown.'),
(52,3,'Pour in the water and cook until the vermicelli softens.'),
(52,4,'Add the sugar and stir until dissolved.'),
(52,5,'Mix in the cardamom and saffron.'),
(52,6,'Cook until the liquid is absorbed.'),
(52,7,'Garnish with the mixed nuts.'),
(52,8,'Serve warm as a traditional Bahraini dessert.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(53,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Flour'),'2 cups'),
(53,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Coconut'),'1 cup'),
(53,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'1 cup'),
(53,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'1/2 cup'),
(53,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Milk'),'1 cup'),
(53,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Egg'),'2'),
(53,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Baking Powder'),'2 tsp'),
(53,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Vanilla Extract'),'1 tsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(53,1,'Preheat the oven to 180°C.'),
(53,2,'Mix the flour, baking powder, and shredded coconut in a bowl.'),
(53,3,'In another bowl, beat the butter and sugar until creamy.'),
(53,4,'Add the eggs, milk, and vanilla extract, then mix well.'),
(53,5,'Gradually add the dry ingredients and stir until smooth.'),
(53,6,'Pour the batter into a greased cake tin.'),
(53,7,'Bake for 35 to 40 minutes or until a toothpick comes out clean.'),
(53,8,'Allow the cake to cool before slicing and serving.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(54,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Samosa Sheets'),'10 sheets'),
(54,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Potato'),'3 medium'),
(54,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Peas'),'1/2 cup'),
(54,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(54,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(54,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Turmeric'),'1/2 tsp'),
(54,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(54,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(54,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'As needed for frying');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(54,1,'Boil and mash the potatoes.'),
(54,2,'Cook the onion, peas, cumin, turmeric, salt, and black pepper in a little oil.'),
(54,3,'Mix the mashed potatoes with the cooked vegetables.'),
(54,4,'Fill each samosa sheet with the potato mixture.'),
(54,5,'Fold and seal the samosas securely.'),
(54,6,'Heat the oil in a deep pan.'),
(54,7,'Fry the samosas until golden brown and crispy.'),
(54,8,'Serve hot with chutney or your favorite dipping sauce.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(55,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Samosa Sheets'),'10 sheets'),
(55,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cheddar Cheese'),'1 cup'),
(55,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Mozzarella Cheese'),'1 cup'),
(55,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'As needed for frying');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(55,1,'Mix the cheddar and mozzarella cheese together.'),
(55,2,'Place a spoonful of the cheese mixture onto each samosa sheet.'),
(55,3,'Fold the sheets into triangle shapes and seal the edges.'),
(55,4,'Heat the oil in a deep frying pan.'),
(55,5,'Carefully place the samosas into the hot oil.'),
(55,6,'Fry until golden brown and crispy.'),
(55,7,'Drain on paper towels to remove excess oil.'),
(55,8,'Serve hot with ketchup or chili sauce.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(56,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Samosa Sheets'),'10 sheets'),
(56,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Minced Beef'),'500 g'),
(56,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(56,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'2 cloves'),
(56,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(56,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(56,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(56,1,'Heat the oil in a pan and sauté the onion until soft.'),
(56,2,'Add the garlic and cook for 1 minute.'),
(56,3,'Add the minced beef and cook until browned.'),
(56,4,'Season with salt and black pepper, then let the filling cool.'),
(56,5,'Place a spoonful of filling onto each samosa sheet.'),
(56,6,'Fold the sheets into triangles and seal the edges.'),
(56,7,'Deep-fry until golden brown and crispy.'),
(56,8,'Serve hot with your favorite dipping sauce.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(57,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Potato'),'4 medium'),
(57,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Egg'),'1'),
(57,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Parsley'),'2 tbsp'),
(57,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Breadcrumbs'),'1 cup'),
(57,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(57,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(57,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'As needed for frying');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(57,1,'Boil the potatoes until tender, then mash them.'),
(57,2,'Mix the potatoes with the egg, parsley, salt, and black pepper.'),
(57,3,'Shape the mixture into small patties.'),
(57,4,'Coat each patty with breadcrumbs.'),
(57,5,'Heat the oil in a frying pan.'),
(57,6,'Fry the cutlets until golden brown on both sides.'),
(57,7,'Drain on paper towels to remove excess oil.'),
(57,8,'Serve hot with ketchup or your favorite dipping sauce.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(58,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Minced Lamb'),'500 g'),
(58,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(58,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'3 cloves'),
(58,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Parsley'),'2 tbsp'),
(58,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(58,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(58,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(58,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'1 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(58,1,'Combine the minced lamb, onion, garlic, parsley, cumin, salt, and black pepper in a bowl.'),
(58,2,'Mix well until all ingredients are evenly combined.'),
(58,3,'Shape the mixture into kebab logs or patties.'),
(58,4,'Lightly brush the kebabs with oil.'),
(58,5,'Preheat a grill or grill pan over medium-high heat.'),
(58,6,'Grill the kebabs for 10–12 minutes, turning occasionally.'),
(58,7,'Cook until browned and fully cooked through.'),
(58,8,'Serve hot with Arabic bread, salad, and yogurt sauce.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(59,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Spring Roll Sheets'),'10 sheets'),
(59,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Minced Beef'),'500 g'),
(59,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(59,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'2 cloves'),
(59,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(59,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(59,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'As needed for frying');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(59,1,'Heat a little oil in a pan and cook the onion until soft.'),
(59,2,'Add the garlic and minced beef, then cook until browned.'),
(59,3,'Season with salt and black pepper and allow the filling to cool.'),
(59,4,'Place a spoonful of the filling onto each spring roll sheet.'),
(59,5,'Roll tightly and seal the edges.'),
(59,6,'Heat oil in a deep frying pan.'),
(59,7,'Fry the rolls until golden brown and crispy.'),
(59,8,'Serve hot with ketchup or chili sauce.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(60,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Grape Leaves'),'30 leaves'),
(60,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rice'),'1 cup'),
(60,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Minced Lamb'),'250 g'),
(60,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(60,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'1 medium'),
(60,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Parsley'),'1/4 cup'),
(60,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lemon Juice'),'2 tbsp'),
(60,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(60,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(60,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(60,1,'Rinse the grape leaves and blanch them in hot water if needed.'),
(60,2,'Mix the rice, minced lamb, onion, tomato, parsley, salt, and black pepper.'),
(60,3,'Place a small amount of filling onto each grape leaf.'),
(60,4,'Roll the leaves tightly and fold in the sides.'),
(60,5,'Arrange the rolls in a pot.'),
(60,6,'Drizzle with oil and lemon juice, then add enough water to cover.'),
(60,7,'Simmer over low heat for about 45 minutes until cooked.'),
(60,8,'Serve warm with yogurt or lemon wedges.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(61,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Pastry Dough'),'500 g'),
(61,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Spinach'),'300 g'),
(61,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(61,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lemon Juice'),'2 tbsp'),
(61,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(61,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(61,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'1 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(61,1,'Preheat the oven to 180°C.'),
(61,2,'Cook the onion in a little oil until soft.'),
(61,3,'Add the spinach and cook until wilted.'),
(61,4,'Mix in the lemon juice, salt, and black pepper, then let the filling cool.'),
(61,5,'Cut the pastry dough into small circles and add the spinach filling.'),
(61,6,'Fold into triangles and seal the edges firmly.'),
(61,7,'Place on a baking tray and bake for 20 to 25 minutes until golden brown.'),
(61,8,'Serve warm as an appetizer or snack.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(62,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'2 cups'),
(62,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Tea'),'2 tsp'),
(62,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Evaporated Milk'),'1 cup'),
(62,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'2 tbsp'),
(62,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cardamom'),'2 pods');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(62,1,'Boil the water in a saucepan.'),
(62,2,'Add the black tea and crushed cardamom.'),
(62,3,'Simmer for 3 to 5 minutes.'),
(62,4,'Add the evaporated milk and sugar.'),
(62,5,'Stir well and bring to a gentle boil.'),
(62,6,'Simmer for another 2 to 3 minutes.'),
(62,7,'Strain the tea into serving cups.'),
(62,8,'Serve hot.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(63,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'4 cups'),
(63,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Arabic Coffee'),'4 tbsp'),
(63,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cardamom'),'4 pods'),
(63,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Saffron'),'1 pinch'),
(63,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Dates'),'6 pieces');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(63,1,'Boil the water in a coffee pot.'),
(63,2,'Add the Arabic coffee and simmer for 10 minutes.'),
(63,3,'Add the crushed cardamom and saffron.'),
(63,4,'Simmer for another 2 to 3 minutes.'),
(63,5,'Remove from the heat and let the coffee settle briefly.'),
(63,6,'Strain the coffee into a traditional dallah.'),
(63,7,'Serve in small cups.'),
(63,8,'Enjoy with fresh dates.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(64,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lemon'),'2'),
(64,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Mint Leaves'),'10 leaves'),
(64,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'2 tbsp'),
(64,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'2 cups'),
(64,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ice Cubes'),'1 cup');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(64,1,'Wash the lemons and mint leaves.'),
(64,2,'Squeeze the lemons and remove the seeds.'),
(64,3,'Add the lemon juice, mint leaves, sugar, and water to a blender.'),
(64,4,'Blend until smooth.'),
(64,5,'Add the ice cubes and blend briefly.'),
(64,6,'Strain the juice if desired.'),
(64,7,'Pour into serving glasses.'),
(64,8,'Serve chilled.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(65,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tamarind'),'200 g'),
(65,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'4 cups'),
(65,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'1/2 cup'),
(65,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ice Cubes'),'1 cup');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(65,1,'Soak the tamarind in warm water for 30 minutes.'),
(65,2,'Mash the tamarind to extract the juice.'),
(65,3,'Strain the mixture to remove seeds and fibers.'),
(65,4,'Add the sugar and stir until dissolved.'),
(65,5,'Add the remaining water and mix well.'),
(65,6,'Chill the juice in the refrigerator.'),
(65,7,'Pour into glasses filled with ice cubes.'),
(65,8,'Serve cold.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(66,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Vimto Syrup'),'1/2 cup'),
(66,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'2 cups'),
(66,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ice Cubes'),'1 cup');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(66,1,'Fill a serving glass with ice cubes.'),
(66,2,'Pour the Vimto syrup into the glass.'),
(66,3,'Add the chilled water.'),
(66,4,'Stir well until combined.'),
(66,5,'Taste and adjust the syrup if desired.'),
(66,6,'Garnish with a lemon slice if preferred.'),
(66,7,'Serve immediately while cold.'),
(66,8,'Enjoy chilled.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(67,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Milk'),'2 cups'),
(67,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rose Syrup'),'3 tbsp'),
(67,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'1 tbsp'),
(67,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ice Cubes'),'1 cup');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(67,1,'Pour the chilled milk into a serving glass.'),
(67,2,'Add the rose syrup and sugar.'),
(67,3,'Stir well until everything is fully mixed.'),
(67,4,'Add the ice cubes.'),
(67,5,'Serve immediately while chilled.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(68,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Dates'),'8 pieces'),
(68,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Milk'),'2 cups'),
(68,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'1 tbsp'),
(68,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ice Cubes'),'1 cup');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(68,1,'Remove the seeds from the dates.'),
(68,2,'Add the dates, milk, and sugar into a blender.'),
(68,3,'Blend until smooth and creamy.'),
(68,4,'Add the ice cubes and blend for a few more seconds.'),
(68,5,'Pour into serving glasses and serve chilled.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(69,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Milk'),'2 cups'),
(69,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Saffron'),'1 pinch'),
(69,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cardamom'),'2 pods'),
(69,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(69,1,'Pour the milk into a saucepan and heat over medium heat.'),
(69,2,'Add the saffron and crushed cardamom to the milk.'),
(69,3,'Stir in the sugar until it dissolves completely.'),
(69,4,'Simmer gently for 5 to 10 minutes to infuse the flavors.'),
(69,5,'Serve warm, or chill before serving if desired.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(70,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'3 medium'),
(70,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(70,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Parsley'),'1/4 cup'),
(70,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lemon Juice'),'2 tbsp'),
(70,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Olive Oil'),'2 tbsp'),
(70,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(70,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(70,1,'Wash and finely chop the tomatoes, onion, and parsley.'),
(70,2,'Place all the chopped ingredients in a mixing bowl.'),
(70,3,'Add the lemon juice and olive oil.'),
(70,4,'Season with salt and black pepper.'),
(70,5,'Mix well until all ingredients are evenly combined.'),
(70,6,'Serve fresh as a side dish.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(71,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cucumber'),'2 medium'),
(71,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(71,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lemon Juice'),'2 tbsp'),
(71,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Olive Oil'),'2 tbsp'),
(71,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(71,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(71,1,'Wash the cucumber and tomatoes thoroughly.'),
(71,2,'Dice the cucumber and tomatoes into small pieces.'),
(71,3,'Place them in a mixing bowl.'),
(71,4,'Add the lemon juice and olive oil.'),
(71,5,'Season with salt and black pepper, then toss well.'),
(71,6,'Serve fresh and chilled.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(72,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Parsley'),'2 cups'),
(72,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Bulgur'),'1/2 cup'),
(72,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(72,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cucumber'),'1 medium'),
(72,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Mint Leaves'),'1/4 cup'),
(72,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 small'),
(72,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lemon Juice'),'3 tbsp'),
(72,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Olive Oil'),'2 tbsp'),
(72,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(72,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(72,1,'Soak the bulgur in water for 15 minutes, then drain well.'),
(72,2,'Finely chop the parsley, mint leaves, tomatoes, cucumber, and onion.'),
(72,3,'Place all the ingredients in a large mixing bowl.'),
(72,4,'Add the soaked bulgur, lemon juice, and olive oil.'),
(72,5,'Season with salt and black pepper.'),
(72,6,'Mix well until all the ingredients are evenly combined.'),
(72,7,'Chill for 15 minutes before serving.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(73,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lettuce'),'2 cups'),
(73,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(73,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cucumber'),'1 medium'),
(73,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Radish'),'4'),
(73,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Mint Leaves'),'1/4 cup'),
(73,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Pita Bread'),'1 piece'),
(73,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lemon Juice'),'3 tbsp'),
(73,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Olive Oil'),'2 tbsp'),
(73,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sumac'),'1 tsp'),
(73,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(73,1,'Wash and chop the lettuce, tomatoes, cucumber, and radishes into bite-sized pieces.'),
(73,2,'Toast or fry the pita bread until crispy, then break it into small pieces.'),
(73,3,'Place the vegetables and mint leaves in a large bowl.'),
(73,4,'Add the toasted pita bread.'),
(73,5,'Mix the lemon juice, olive oil, sumac, and salt to prepare the dressing.'),
(73,6,'Pour the dressing over the salad and toss gently.'),
(73,7,'Serve immediately to keep the bread crispy.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(74,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lettuce'),'2 cups'),
(74,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cucumber'),'1 medium'),
(74,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(74,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 small'),
(74,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lemon Juice'),'2 tbsp'),
(74,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Olive Oil'),'2 tbsp'),
(74,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(74,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(74,1,'Wash the lettuce, cucumber, tomatoes, and onion thoroughly.'),
(74,2,'Chop the vegetables into bite-sized pieces.'),
(74,3,'Place all the vegetables in a large salad bowl.'),
(74,4,'Mix the lemon juice, olive oil, salt, and black pepper to prepare the dressing.'),
(74,5,'Pour the dressing over the salad and toss gently until evenly coated.'),
(74,6,'Serve immediately while fresh.');

