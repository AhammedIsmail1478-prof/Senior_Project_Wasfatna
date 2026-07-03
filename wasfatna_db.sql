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

