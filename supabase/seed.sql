-- categories.sql
INSERT INTO
  public.categories (id, name, parent_id)
VALUES
  (uuid_generate_v4 (), 'Alcoholic Beverages', NULL),
  (uuid_generate_v4 (), 'Non-Alcoholic Beverages', NULL);


WITH
  alcoholic_id AS (
    SELECT
      id
    FROM
      categories
    WHERE
      name = 'Alcoholic Beverages'
  ),
  non_alcoholic_id AS (
    SELECT
      id
    FROM
      categories
    WHERE
      name = 'Non-Alcoholic Beverages'
  )
INSERT INTO
  public.categories (id, name, parent_id)
VALUES
  (
    uuid_generate_v4 (),
    'Vodka',
    (
      SELECT
        id
      FROM
        alcoholic_id
    )
  ),
  (
    uuid_generate_v4 (),
    'Gin',
    (
      SELECT
        id
      FROM
        alcoholic_id
    )
  ),
  (
    uuid_generate_v4 (),
    'Rum',
    (
      SELECT
        id
      FROM
        alcoholic_id
    )
  ),
  (
    uuid_generate_v4 (),
    'Tequila',
    (
      SELECT
        id
      FROM
        alcoholic_id
    )
  ),
  (
    uuid_generate_v4 (),
    'Scotch',
    (
      SELECT
        id
      FROM
        alcoholic_id
    )
  ),
  (
    uuid_generate_v4 (),
    'Bourbon',
    (
      SELECT
        id
      FROM
        alcoholic_id
    )
  ),
  (
    uuid_generate_v4 (),
    'Brandy',
    (
      SELECT
        id
      FROM
        alcoholic_id
    )
  ),
  (
    uuid_generate_v4 (),
    'Cognac',
    (
      SELECT
        id
      FROM
        alcoholic_id
    )
  ),
  (
    uuid_generate_v4 (),
    'Liqueurs',
    (
      SELECT
        id
      FROM
        alcoholic_id
    )
  ),
  (
    uuid_generate_v4 (),
    'Cocktails',
    (
      SELECT
        id
      FROM
        alcoholic_id
    )
  ),
  (
    uuid_generate_v4 (),
    'Juices',
    (
      SELECT
        id
      FROM
        non_alcoholic_id
    )
  );


-- recipes.sql
INSERT INTO
  public.recipes (id, name, image_url, description)
VALUES
  (
    uuid_generate_v4 (),
    'Margarita',
    'https://source.unsplash.com/random/500×500/?Margarita',
    'The Margarita is a popular Mexican cocktail made with tequila, lime juice, and Cointreau. Its exact origins are unknown, but it was first popularized in the United States in the late 1930s.'
  ),
  (
    uuid_generate_v4 (),
    'Mojito',
    'https://source.unsplash.com/random/500×500/?Mojito',
    'The Mojito is a traditional Cuban cocktail that combines five ingredients: white rum, sugar, lime juice, soda water, and mint. It dates back to the 16th century, where it was originally known as "El Draque" in honor of Sir Francis Drake.'
  ),
  (
    uuid_generate_v4 (),
    'Cosmopolitan',
    'https://source.unsplash.com/random/500×500/?Cosmopolitan',
    'The Cosmopolitan, also known as the Cosmo, is a chic vodka-based cocktail that originated in the 1970s in the USA. Its rise in popularity was largely due to its frequent mention on the television show Sex and the City.'
  ),
  (
    uuid_generate_v4 (),
    'Old Fashioned',
    'https://source.unsplash.com/random/500×500/?Old+Fashioned',
    'The Old Fashioned is a classic American cocktail made with whiskey, bitters, sugar, and water. Its name comes from its age - it is considered one of the oldest known cocktails, dating back to the early 19th century.'
  ),
  (
    uuid_generate_v4 (),
    'Martini',
    'https://source.unsplash.com/random/500×500/?Martini',
    'The Martini is a classic cocktail that has stood the test of time. Originating in the United States in the 19th century, it is typically made with gin and vermouth and garnished with an olive or a lemon twist.'
  );


-- steps.sql
INSERT INTO
  public.steps (id, recipe_id, number, description)
VALUES
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Margarita'
    ),
    1,
    'Rub the rim of the glass with the lime slice to make the salt stick to it. Take care to moisten only the outer rim and sprinkle the salt on it.'
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Margarita'
    ),
    2,
    'Shake the other ingredients with ice, then carefully pour into the glass (taking care not to dislodge any salt).'
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Mojito'
    ),
    1,
    'Muddle mint leaves with sugar and lime juice.'
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Mojito'
    ),
    2,
    'Add a splash of soda water and fill the glass with ice.'
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Cosmopolitan'
    ),
    1,
    'Add all ingredients into a shaker with ice and shake.'
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Old Fashioned'
    ),
    1,
    'In a rocks glass, muddle the sugar, bitters, and water.'
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Old Fashioned'
    ),
    2,
    'Add the ice and bourbon and stir.'
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Martini'
    ),
    1,
    'Add all ingredients into a shaker with ice and shake.'
  );


-- units.sql
INSERT INTO
  public.units (id, name)
VALUES
  (uuid_generate_v4 (), 'ml'),
  (uuid_generate_v4 (), 'dash'),
  (uuid_generate_v4 (), 'N/A'),
  (uuid_generate_v4 (), 'oz'),
  (uuid_generate_v4 (), 'part');


-- ingredients.sql
INSERT INTO
  public.ingredients (id, name, weight, image_url, description)
VALUES
  (
    uuid_generate_v4 (),
    'Lime Juice',
    1,
    'https://source.unsplash.com/random/500×500/?lime',
    'Freshly squeezed lime juice adds a bright, citrusy flavor to cocktails.'
  ),
  (
    uuid_generate_v4 (),
    'Tequila',
    2,
    'https://source.unsplash.com/random/500×500/?tequila',
    'Tequila is a distilled spirit made from the blue agave plant, primarily produced in the area surrounding the city of Tequila, 65 km (40 mi) northwest of Guadalajara, and in the Jaliscan Highlands (Los Altos de Jalisco) of the central western Mexican state of Jalisco.'
  ),
  (
    uuid_generate_v4 (),
    'Triple Sec',
    3,
    'https://source.unsplash.com/random/500×500/?triple-sec',
    'Triple sec is a sweet, colorless, orange-flavored liqueur.'
  ),
  (
    uuid_generate_v4 (),
    'Mint Leaves',
    4,
    'https://source.unsplash.com/random/500×500/?mint',
    'Mint leaves add a refreshing, herbal note to cocktails.'
  ),
  (
    uuid_generate_v4 (),
    'White Rum',
    5,
    'https://source.unsplash.com/random/500×500/?rum',
    'White rum is a clear, light-bodied rum that is typically used in cocktails.'
  ),
  (
    uuid_generate_v4 (),
    'Sugar',
    6,
    'https://source.unsplash.com/random/500×500/?sugar',
    'Sugar is a common sweetener used in cocktails.'
  ),
  (
    uuid_generate_v4 (),
    'Vodka',
    7,
    'https://source.unsplash.com/random/500×500/?vodka',
    'Vodka is a clear, neutral spirit that is typically distilled from grains or potatoes.'
  ),
  (
    uuid_generate_v4 (),
    'Gin',
    8,
    'https://source.unsplash.com/random/500×500/?gin',
    'Gin is a distilled spirit that is flavored with juniper berries and other botanicals.'
  ),
  (
    uuid_generate_v4 (),
    'Bourbon',
    9,
    'https://source.unsplash.com/random/500×500/?bourbon',
    'Bourbon is a type of American whiskey that is distilled from a mash bill that is at least 51% corn.'
  ),
  (
    uuid_generate_v4 (),
    'Angostura Bitters',
    10,
    'https://source.unsplash.com/random/500×500/?bitters',
    'Angostura bitters is a concentrated bitters made from a secret blend of herbs and spices.'
  ),
  (
    uuid_generate_v4 (),
    'Cranberry Juice',
    11,
    'https://source.unsplash.com/random/500×500/?cranberry-juice',
    'Cranberry juice is a tart, fruity juice that is commonly used in cocktails.'
  ),
  (
    uuid_generate_v4 (),
    'Orange Zest',
    12,
    'https://source.unsplash.com/random/500×500/?orange',
    'Orange zest is the outermost layer of the orange peel, which contains flavorful oils that add a bright, citrusy note to cocktails.'
  ),
  (
    uuid_generate_v4 (),
    'Sweet Vermouth',
    13,
    'https://source.unsplash.com/random/500×500/?vermouth',
    'Sweet vermouth is a fortified wine that is flavored with herbs and spices.'
  );


-- recipes_categories.sql
INSERT INTO
  public.recipes_categories (id, recipe_id, category_id)
VALUES
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Margarita'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Tequila'
    )
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Mojito'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Rum'
    )
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Cosmopolitan'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Vodka'
    )
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Old Fashioned'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Bourbon'
    )
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Martini'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Gin'
    )
  );


-- ingredients_categories.sql
INSERT INTO
  public.ingredients_categories (id, ingredient_id, category_id)
VALUES
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Lime Juice'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Cocktails'
    )
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Tequila'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Tequila'
    )
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Triple Sec'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Cocktails'
    )
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Mint Leaves'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Cocktails'
    )
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'White Rum'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Rum'
    )
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Sugar'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Cocktails'
    )
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Vodka'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Vodka'
    )
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Gin'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Gin'
    )
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Bourbon'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Bourbon'
    )
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Angostura Bitters'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Cocktails'
    )
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Cranberry Juice'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Cocktails'
    )
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Orange Zest'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Cocktails'
    )
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Sweet Vermouth'
    ),
    (
      SELECT
        id
      FROM
        public.categories
      WHERE
        name = 'Cocktails'
    )
  );


-- recipes_ingredients.sql
INSERT INTO
  public.recipes_ingredients (id, recipe_id, ingredient_id, unit_id, quantity)
VALUES
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Margarita'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Lime Juice'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'ml'
    ),
    30
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Margarita'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Tequila'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'ml'
    ),
    60
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Margarita'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Triple Sec'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'ml'
    ),
    30
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Margarita'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Salt'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'N/A'
    ),
    null
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Mojito'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Mint Leaves'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'part'
    ),
    2
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Mojito'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Lime Juice'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'oz'
    ),
    1
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Mojito'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'White Rum'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'oz'
    ),
    2
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Mojito'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Sugar'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'oz'
    ),
    1
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Mojito'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Soda Water'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'oz'
    ),
    2
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Cosmopolitan'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Vodka'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'oz'
    ),
    1.5
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Cosmopolitan'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Cranberry Juice'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'oz'
    ),
    1
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Cosmopolitan'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Lime Juice'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'oz'
    ),
    0.5
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Cosmopolitan'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Triple Sec'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'oz'
    ),
    0.5
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Old Fashioned'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Sugar'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'dash'
    ),
    1
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Old Fashioned'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Bourbon'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'oz'
    ),
    2.5
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Old Fashioned'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Angostura Bitters'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'dash'
    ),
    2
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Old Fashioned'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Water'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'dash'
    ),
    1
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Martini'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Gin'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'oz'
    ),
    2.5
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Martini'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Dry Vermouth'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'oz'
    ),
    0.5
  ),
  (
    uuid_generate_v4 (),
    (
      SELECT
        id
      FROM
        public.recipes
      WHERE
        name = 'Martini'
    ),
    (
      SELECT
        id
      FROM
        public.ingredients
      WHERE
        name = 'Olive'
    ),
    (
      SELECT
        id
      FROM
        public.units
      WHERE
        name = 'N/A'
    ),
    null
  );