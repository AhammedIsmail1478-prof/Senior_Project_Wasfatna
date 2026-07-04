CREATE DATABASE wasfatna_db;
USE wasfatna_db;

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
('Drinks');

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
('Green Chilli'),
('Hammour Fish'),
('Paprika'),
('Shrimp'),
('Kingfish'),
('Curry Powder),
('Coconut Milk'),
('Flour'),
('Cornstarch'),
('Breadcrumbs'),
('Mixed Seafood),
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
('Yeast');

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
(17,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Vermicelli'),'300 g'),
(17,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Egg'),'4'),
(17,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Sugar'),'1/2 cup'),
(17,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'3 tbsp'),
(17,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cardamom'),'1 tsp'),
(17,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Saffron'),'1 pinch'),
(17,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rose Water'),'1 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(17,1,'Boil the vermicelli until tender, then drain.'),
(17,2,'Melt the butter in a pan and stir in the sugar.'),
(17,3,'Add saffron, cardamom, and rose water, then mix well.'),
(17,4,'Add the cooked vermicelli and stir until evenly coated.'),
(17,5,'Beat the eggs with a pinch of salt.'),
(17,6,'Cook the eggs into a thin omelet.'),
(17,7,'Place the omelet over the sweet vermicelli.'),
(17,8,'Serve warm.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Egg'),'4'),
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Green Chili'),'1'),
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(18,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(18,1,'Heat the oil in a frying pan.'),
(18,2,'Sauté the chopped onion until soft.'),
(18,3,'Add the chopped tomatoes and green chili, then cook until softened.'),
(18,4,'Beat the eggs with salt and black pepper.'),
(18,5,'Pour the eggs over the tomato mixture.'),
(18,6,'Cook on low heat until the eggs are fully set.'),
(18,7,'Serve hot with Arabic bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(19,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Hammour Fish'),'1 whole'),
(19,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(19,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(19,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lemon Juice'),'2 tbsp'),
(19,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Paprika'),'1 tsp'),
(19,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(19,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(19,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(19,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(19,1,'Clean and wash the hammour fish thoroughly.'),
(19,2,'Mix garlic, ginger, lemon juice, paprika, cumin, salt, and black pepper into a marinade.'),
(19,3,'Coat the fish evenly with the marinade and let it rest for 30 minutes.'),
(19,4,'Brush the fish lightly with oil.'),
(19,5,'Grill the fish over medium heat until fully cooked, turning once.'),
(19,6,'Serve hot with rice, salad, and lemon wedges.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Shrimp'),'1 kg'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rice'),'3 cups'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Machboos Spice'),'2 tbsp'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Turmeric'),'1 tsp'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(20,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(20,1,'Clean and devein the shrimp thoroughly.'),
(20,2,'Heat oil and fry the onions until golden brown.'),
(20,3,'Add garlic, ginger, and tomatoes, then cook until softened.'),
(20,4,'Add Machboos spice, turmeric, salt, and black pepper.'),
(20,5,'Add the shrimp and cook for 3–5 minutes.'),
(20,6,'Add the rice and enough water or stock.'),
(20,7,'Cook until the rice is tender and the liquid is absorbed.'),
(20,8,'Serve hot with salad and lemon wedges.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Kingfish'),'1 whole'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lemon Juice'),'2 tbsp'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Paprika'),'1 tsp'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(21,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(21,1,'Clean and wash the kingfish thoroughly.'),
(21,2,'Prepare a marinade using garlic, ginger, lemon juice, paprika, cumin, salt, and black pepper.'),
(21,3,'Coat the fish evenly with the marinade and let it rest for 30 minutes.'),
(21,4,'Brush the fish lightly with oil.'),
(21,5,'Grill the fish over medium heat for 6–8 minutes on each side until fully cooked.'),
(21,6,'Serve hot with rice, grilled vegetables, or salad.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Shrimp'),'500 g'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'3 cloves'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Green Chili'),'1'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Curry Powder'),'2 tbsp'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Coconut Milk'),'1 cup'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(22,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(22,1,'Clean and devein the shrimp thoroughly.'),
(22,2,'Heat the oil and sauté the onion until soft.'),
(22,3,'Add garlic, ginger, and green chili, then cook for 2 minutes.'),
(22,4,'Add the tomatoes and curry powder, then cook until the tomatoes soften.'),
(22,5,'Pour in the coconut milk and stir well.'),
(22,6,'Add the shrimp and cook for 5–7 minutes until pink and fully cooked.'),
(22,7,'Season with salt and black pepper.'),
(22,8,'Serve hot with steamed rice.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Shrimp'),'500 g'),
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Flour'),'1 cup'),
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cornstarch'),'1/2 cup'),
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Egg'),'2'),
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Breadcrumbs'),'1 cup'),
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(23,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'500 ml');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(23,1,'Clean and devein the shrimp thoroughly.'),
(23,2,'Season the shrimp with salt and black pepper.'),
(23,3,'Coat each shrimp with flour.'),
(23,4,'Dip the shrimp into the beaten eggs.'),
(23,5,'Cover the shrimp evenly with breadcrumbs.'),
(23,6,'Heat the oil in a deep frying pan.'),
(23,7,'Fry the shrimp until golden brown and crispy.'),
(23,8,'Drain on paper towels and serve hot with dipping sauce.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Fish'),'1 kg'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Green Chili'),'1'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Curry Powder'),'2 tbsp'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Coconut Milk'),'1 cup'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(24,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(24,1,'Clean and cut the fish into medium-sized pieces.'),
(24,2,'Heat the oil and sauté the onion until soft.'),
(24,3,'Add garlic, ginger, and green chili, then cook for 2 minutes.'),
(24,4,'Add tomatoes and curry powder, then cook until the tomatoes soften.'),
(24,5,'Pour in the coconut milk and stir well.'),
(24,6,'Add the fish and simmer gently for 10–12 minutes until cooked.'),
(24,7,'Season with salt and black pepper.'),
(24,8,'Serve hot with steamed rice or bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Fish'),'1 kg'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Green Chili'),'1'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Curry Powder'),'2 tbsp'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Coconut Milk'),'1 cup'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(25,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(25,1,'Clean and cut the fish into medium-sized pieces.'),
(25,2,'Heat the oil and sauté the onion until soft.'),
(25,3,'Add garlic, ginger, and green chili, then cook for 2 minutes.'),
(25,4,'Add tomatoes and curry powder and cook until the tomatoes soften.'),
(25,5,'Pour in the coconut milk and stir well.'),
(25,6,'Add the fish and simmer gently for 10 to 12 minutes until fully cooked.'),
(25,7,'Season with salt and black pepper to taste.'),
(25,8,'Serve hot with steamed rice or Arabic bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Mixed Seafood'),'1 kg'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Potato'),'2 medium'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Carrot'),'2 medium'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Bell Pepper'),'1 medium'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato Paste'),'2 tbsp'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Coriander'),'2 tbsp'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(26,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(26,1,'Clean and prepare the mixed seafood.'),
(26,2,'Heat the oil and sauté the onions until soft.'),
(26,3,'Add garlic and ginger, then cook for 2 minutes.'),
(26,4,'Add tomatoes and tomato paste, then cook until softened.'),
(26,5,'Add potato, carrot, and bell pepper.'),
(26,6,'Season with cumin, coriander, salt, and black pepper.'),
(26,7,'Add the mixed seafood and enough water, then simmer until the vegetables are tender and the seafood is cooked.'),
(26,8,'Serve hot with rice or Arabic bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Prawns'),'500 g'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Rice'),'3 cups'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Turmeric'),'1 tsp'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(27,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(27,1,'Clean and devein the prawns thoroughly.'),
(27,2,'Heat the oil and fry the onions until golden brown.'),
(27,3,'Add garlic, ginger, and tomatoes, then cook until softened.'),
(27,4,'Add turmeric, salt, and black pepper, then mix well.'),
(27,5,'Add the prawns and cook for 3 to 4 minutes.'),
(27,6,'Add the rice and enough water, then stir well.'),
(27,7,'Cook until the rice is tender and the liquid is absorbed.'),
(27,8,'Serve hot with salad and lemon wedges.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Safi Fish'),'1 whole'),
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Turmeric'),'1 tsp'),
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Paprika'),'1 tsp'),
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lemon Juice'),'2 tbsp'),
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(28,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(28,1,'Clean and wash the Safi fish thoroughly.'),
(28,2,'Prepare a marinade using garlic, ginger, turmeric, paprika, lemon juice, salt, and black pepper.'),
(28,3,'Coat the fish evenly with the marinade and let it rest for 30 minutes.'),
(28,4,'Heat the oil in a frying pan.'),
(28,5,'Fry the fish on both sides until golden brown and fully cooked.'),
(28,6,'Drain excess oil and serve hot with rice, salad, and lemon wedges.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Fish'),'1 kg'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'2 medium'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'4 cloves'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Potato'),'2 medium'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Carrot'),'1 medium'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato Paste'),'2 tbsp'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Coriander'),'1 tbsp'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(29,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'3 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(29,1,'Clean and cut the fish into medium-sized pieces.'),
(29,2,'Heat the oil and sauté the onions until soft.'),
(29,3,'Add garlic, ginger, tomatoes, and tomato paste, then cook well.'),
(29,4,'Add the potato and carrot and stir for a few minutes.'),
(29,5,'Season with cumin, coriander, salt, and black pepper.'),
(29,6,'Add enough water and simmer until the vegetables are almost tender.'),
(29,7,'Add the fish and cook gently until fully cooked.'),
(29,8,'Serve hot with rice or fresh bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Shrimp'),'500 g'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'5 cloves'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Green Chili'),'2'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Chili Flakes'),'1 tsp'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Paprika'),'1 tsp'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Lemon Juice'),'2 tbsp'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(30,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(30,1,'Clean and devein the shrimp thoroughly.'),
(30,2,'Season the shrimp with salt, black pepper, paprika, and lemon juice.'),
(30,3,'Heat the oil in a frying pan.'),
(30,4,'Sauté the garlic, ginger, and green chili until fragrant.'),
(30,5,'Add the shrimp and cook for 3 to 5 minutes.'),
(30,6,'Sprinkle the chili flakes and stir well.'),
(30,7,'Cook until the shrimp are fully cooked and coated with the spices.'),
(30,8,'Serve hot with rice, bread, or a fresh salad.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Red Lentils'),'2 cups'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'3 cloves'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Cumin'),'1 tsp'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Turmeric'),'1/2 tsp'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp'),
(31,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'5 cups');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(31,1,'Wash the red lentils thoroughly.'),
(31,2,'Heat the oil and sauté the onion until soft.'),
(31,3,'Add garlic, ginger, and tomatoes, then cook until softened.'),
(31,4,'Add the red lentils, cumin, turmeric, salt, and black pepper.'),
(31,5,'Pour in the water and bring to a boil.'),
(31,6,'Reduce the heat and simmer until the lentils are tender.'),
(31,7,'Blend the soup until smooth if desired.'),
(31,8,'Serve hot with lemon wedges or fresh bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(32,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Chicken'),'500 g'),
(32,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(32,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'3 cloves'),
(32,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(32,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Carrot'),'1 medium'),
(32,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Chicken Stock'),'4 cups'),
(32,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Bay Leaf'),'1'),
(32,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(32,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(32,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'1 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(32,1,'Cut the chicken into small pieces.'),
(32,2,'Heat the oil and sauté the onion until soft.'),
(32,3,'Add the garlic and ginger, then cook for 2 minutes.'),
(32,4,'Add the chicken and cook until lightly browned.'),
(32,5,'Add the carrot, chicken stock, and bay leaf.'),
(32,6,'Season with salt and black pepper.'),
(32,7,'Simmer for 30 minutes until the chicken is tender.'),
(32,8,'Serve hot with fresh bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(33,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Carrot'),'2 medium'),
(33,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Potato'),'2 medium'),
(33,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Peas'),'1 cup'),
(33,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Celery'),'2 stalks'),
(33,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(33,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(33,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'3 cloves'),
(33,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(33,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(33,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(33,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp'),
(33,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'5 cups');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(33,1,'Wash and chop all the vegetables into small pieces.'),
(33,2,'Heat the oil and sauté the onion until soft.'),
(33,3,'Add the garlic and ginger, then cook for 2 minutes.'),
(33,4,'Add the tomatoes, carrots, potatoes, peas, and celery.'),
(33,5,'Season with salt and black pepper.'),
(33,6,'Pour in the water and bring to a boil.'),
(33,7,'Simmer for 25 to 30 minutes until the vegetables are tender.'),
(33,8,'Serve hot with fresh bread or crackers.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(34,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Chicken'),'500 g'),
(34,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Wheat'),'1 cup'),
(34,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(34,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'3 cloves'),
(34,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(34,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Chicken Stock'),'5 cups'),
(34,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(34,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(34,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ground Cinnamon'),'1/2 tsp'),
(34,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Butter'),'1 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(34,1,'Wash the wheat and soak it for at least 2 hours.'),
(34,2,'Cook the chicken until tender, then shred it into small pieces.'),
(34,3,'Heat butter and sauté the onion, garlic, and ginger.'),
(34,4,'Add the soaked wheat and chicken stock.'),
(34,5,'Add the shredded chicken, salt, black pepper, and ground cinnamon.'),
(34,6,'Simmer on low heat until the wheat becomes very soft.'),
(34,7,'Stir continuously until the soup reaches a smooth and creamy consistency.'),
(34,8,'Serve hot with a sprinkle of cinnamon if desired.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Mixed Seafood'),'500 g'),
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Onion'),'1 medium'),
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Tomato'),'2 medium'),
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Garlic'),'3 cloves'),
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Ginger'),'1 tbsp'),
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Fish Stock'),'4 cups'),
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Parsley'),'2 tbsp'),
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Black Pepper'),'1/2 tsp'),
(35,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(35,1,'Clean and prepare the mixed seafood.'),
(35,2,'Heat the oil and sauté the onion until soft.'),
(35,3,'Add the garlic, ginger, and tomatoes, then cook until softened.'),
(35,4,'Pour in the fish stock and bring it to a boil.'),
(35,5,'Add the mixed seafood and cook for 8 to 10 minutes.'),
(35,6,'Season with salt and black pepper.'),
(35,7,'Stir in the chopped parsley and simmer for 2 minutes.'),
(35,8,'Serve hot with lemon wedges and fresh bread.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity)
VALUES
(36,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Flour'),'4 cups'),
(36,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Yeast'),'1 tbsp'),
(36,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Salt'),'1 tsp'),
(36,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Water'),'1½ cups'),
(36,(SELECT ingredient_id FROM ingredients WHERE ingredient_name='Oil'),'2 tbsp');

INSERT INTO recipe_steps (recipe_id, step_number, instruction)
VALUES
(36,1,'Mix the flour, yeast, and salt in a large bowl.'),
(36,2,'Gradually add the water and knead into a smooth dough.'),
(36,3,'Add the oil and continue kneading until the dough is soft.'),
(36,4,'Cover the dough and let it rise for 1 hour.'),
(36,5,'Divide the dough into equal portions and flatten into round breads.'),
(36,6,'Bake in a preheated oven until golden brown.'),
(36,7,'Remove from the oven and brush lightly with oil if desired.'),
(36,8,'Serve warm with curries, soups, or breakfast dishes.');
