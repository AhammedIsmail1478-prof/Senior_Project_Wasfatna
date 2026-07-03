CREATE DATABASE wasfatna_db;
USE wasfatna_db;

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE recipes (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    recipe_name VARCHAR(100) NOT NULL,
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
    ingredient_name VARCHAR(100) NOT NULL
);

CREATE TABLE recipe_ingredients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantity VARCHAR(50),

    FOREIGN KEY(recipe_id)
    REFERENCES recipes(recipe_id),

    FOREIGN KEY(ingredient_id)
    REFERENCES ingredients(ingredient_id)
);

CREATE TABLE recipe_steps (
    step_id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT NOT NULL,
    step_number INT,
    instruction TEXT,

    FOREIGN KEY(recipe_id)
    REFERENCES recipes(recipe_id)
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
