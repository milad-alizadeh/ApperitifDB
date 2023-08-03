INSERT INTO
  public.categories (id, name, created_at, updated_at)
VALUES
  (
    'c2d29867-3d0b-d497-9191-18a9d8ee7830',
    'Sours',
    '2019-01-01T00:00:00.000Z',
    '2019-01-01T00:00:00.000Z'
  );

INSERT INTO
  public.recipes (id, name, image_url, created_at, updated_at)
VALUES
  (
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    'Whiskey Sours',
    'https://source.unsplash.com/random/500×500/?cocktails',
    '2019-01-01T00:00:00.000Z',
    '2019-01-01T00:00:00.000Z'
  );

INSERT INTO
  public.steps(
    id,
    recipe_id,
    number,
    description,
    created_at,
    updated_at
  )
VALUES
  (
    'e0bd7b69-868f-4693-b405-950369cf0c10',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    1,
    'Add all ingredients to a shaker and dry shake for 10 seconds.',
    '2019-01-01T00:00:00.000Z',
    '2019-01-01T00:00:00.000Z'
  ),
  (
    '85c9d2f3-fb95-43c5-8b8e-2ec4f4c1fa4e',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    2,
    'Add ice to the shaker and shake again for 10 seconds.',
    '2019-01-01T00:00:00.000Z',
    '2019-01-01T00:00:00.000Z'
  ),
  (
    'd35f129a-43a4-4bea-9f29-65566405c9a2',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    3,
    'Strain into a rocks glass over ice and garnish with a lemon zest.',
    '2019-01-01T00:00:00.000Z',
    '2019-01-01T00:00:00.000Z'
  );

INSERT INTO
  public.ingredients (
    id,
    name,
    unit,
    weight,
    created_at,
    updated_at
  )
VALUES
  (
    'a04e3700-5320-48de-a813-2d64bc184faf',
    'Egg White',
    'ml',
    1,
    '2019-01-01T00:00:00.000Z',
    '2019-01-01T00:00:00.000Z'
  ),
  (
    '0ecfd3a8-580b-4236-9ac7-02d7c7c1089d',
    'Bourbon',
    'ml',
    2,
    '2019-01-01T00:00:00.000Z',
    '2019-01-01T00:00:00.000Z'
  ),
  (
    '2cbafcb3-19de-4b00-848e-0979b32ec09e',
    'Angostura Bitters',
    'dash',
    3,
    '2019-01-01T00:00:00.000Z',
    '2019-01-01T00:00:00.000Z'
  ),
  (
    '9e536f62-c639-42af-afec-244f77b155ee',
    'Lemon Zest',
    null,
    4,
    '2019-01-01T00:00:00.000Z',
    '2019-01-01T00:00:00.000Z'
  ),
  (
    '82fb793b-0401-402d-a103-6eacde0ac434',
    'Simple Syrup',
    'ml',
    5,
    '2019-01-01T00:00:00.000Z',
    '2019-01-01T00:00:00.000Z'
  );

INSERT INTO
  public.recipes_categories (
    id,
    recipe_id,
    category_id,
    created_at,
    updated_at
  )
VALUES
  (
    '7e4181cc-53c3-4ee5-9afc-574ccb847470',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    'c2d29867-3d0b-d497-9191-18a9d8ee7830',
    '2019-01-01T00:00:00.000Z',
    '2019-01-01T00:00:00.000Z'
  );

INSERT INTO
  public.recipes_ingredients (
    id,
    recipe_id,
    ingredient_id,
    quantity,
    created_at,
    updated_at
  )
VALUES
  (
    'adcafa16-a87e-47ce-9870-60e03dcc7f8e',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    'a04e3700-5320-48de-a813-2d64bc184faf',
    30,
    '2019-01-01T00:00:00.000Z',
    '2019-01-01T00:00:00.000Z'
  ),
  (
    'f9cb17e9-5022-425e-a9ff-526c9547779c',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    '0ecfd3a8-580b-4236-9ac7-02d7c7c1089d',
    60,
    '2019-01-01T00:00:00.000Z',
    '2019-01-01T00:00:00.000Z'
  ),
  (
    'fa9c3b99-a67d-4eeb-906e-20a15f3573ee',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    '2cbafcb3-19de-4b00-848e-0979b32ec09e',
    2,
    '2019-01-01T00:00:00.000Z',
    '2019-01-01T00:00:00.000Z'
  ),
  (
    '63e50e5e-dae3-4bfa-b961-e5cf554e9d9d',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    '9e536f62-c639-42af-afec-244f77b155ee',
    null,
    '2019-01-01T00:00:00.000Z',
    '2019-01-01T00:00:00.000Z'
  ),
  (
    '7e4181cc-53c3-4ee5-9afc-574ccb847470',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    '82fb793b-0401-402d-a103-6eacde0ac434',
    22.5,
    '2019-01-01T00:00:00.000Z',
    '2019-01-01T00:00:00.000Z'
  );