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
('Grilled'),
('Breakfast'),
('Dessert'),
('Soup'),
('Salad'),
('Drinks');

INSERT INTO recipes
(category_id,recipe_name,description,prep_time,cook_time,servings,difficulty,calories,image)

VALUES

(1,'Chicken Machboos','Traditional Bahraini spiced chicken rice.',20,60,6,'Medium',680,'chicken_machboos.jpg'),

(1,'Lamb Machboos','Traditional Bahraini lamb rice.',25,90,6,'Medium',780,'lamb_machboos.jpg'),

(1,'Fish Machboos','Spiced rice served with local fish.',20,45,5,'Medium',610,'fish_machboos.jpg'),

(1,'Muhammar','Sweet saffron rice served with fish.',20,40,5,'Easy',520,'muhammar.jpg'),

(1,'Ghoozi','Slow cooked lamb with fragrant rice.',30,120,8,'Hard',890,'ghoozi.jpg'),

(1,'Harees','Slow cooked wheat and meat.',20,180,6,'Medium',470,'harees.jpg'),

(1,'Thareed','Bread soaked in flavorful stew.',20,60,5,'Medium',520,'thareed.jpg'),

(1,'Chicken Madrouba','Creamy rice with shredded chicken.',20,70,6,'Medium',640,'chicken_madrouba.jpg'),

(1,'Fish Madrouba','Creamy fish rice dish.',20,60,5,'Medium',590,'fish_madrouba.jpg'),

(1,'Samak Mashwi','Traditional grilled Bahraini fish.',15,30,4,'Easy',390,'samak_mashwi.jpg'),

(1,'Qabooli Rice','Spiced rice with raisins and nuts.',20,55,6,'Medium',610,'qabooli_rice.jpg'),

(1,'Bahraini Style Biryani','Bahraini version of biryani.',30,75,6,'Medium',720,'bahraini_biryani.jpg'),

(1,'Chicken Saloona','Chicken cooked in vegetable gravy.',20,50,5,'Easy',460,'chicken_saloona.jpg'),

(1,'Lamb Saloona','Lamb stew with vegetables.',25,90,6,'Medium',620,'lamb_saloona.jpg'),

(1,'Vegetable Saloona','Mixed vegetable curry.',15,40,5,'Easy',310,'vegetable_saloona.jpg'),

(1,'Jasheed','Traditional shark meat curry.',20,60,5,'Medium',480,'jasheed.jpg');


