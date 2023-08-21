INSERT INTO
  public.tag_groups (id, name)
VALUES
  (
    'cd0520e0-1a3c-43b6-9d4a-fa0f3b1794ea',
    'Flavour'
  ),
  (
    '55641dda-41dc-4945-b125-6032626741db',
    'Glass Type'
  );

INSERT INTO
  public.tags (id, name, group_id)
VALUES
  (
    '4acb9163-4149-47e2-b98a-2e84b74c711e',
    'highball',
    '55641dda-41dc-4945-b125-6032626741db'
  ),
  (
    'c2d29867-3d0b-d497-9191-18a9d8ee7830',
    'cobbler',
    '55641dda-41dc-4945-b125-6032626741db'
  ),
  (
    'c2b8c518-54ab-4475-b169-891afe039d17',
    'Fruity',
    'cd0520e0-1a3c-43b6-9d4a-fa0f3b1794ea'
  );

INSERT INTO
  public.recipes (id, name, image_url)
VALUES
  (
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    'Whiskey Sours',
    'https://source.unsplash.com/random/500×500/?cocktails'
  );

INSERT INTO
  public.steps(
    id,
    recipe_id,
    number,
    description
  )
VALUES
  (
    'e0bd7b69-868f-4693-b405-950369cf0c10',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    1,
    'Add all ingredients to a shaker and dry shake for 10 seconds.'
  ),
  (
    '85c9d2f3-fb95-43c5-8b8e-2ec4f4c1fa4e',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    2,
    'Add ice to the shaker and shake again for 10 seconds.'
  ),
  (
    'd35f129a-43a4-4bea-9f29-65566405c9a2',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    3,
    'Strain into a rocks glass over ice and garnish with a lemon zest.'
  );

INSERT INTO
  public.units (id, name)
VALUES
  (
    '4c403c4c-7eaf-4579-a50c-af0c9a5a05a9',
    'ml'
  ),
  (
    'b3660fd3-75f2-4e88-a196-eb64b02d8fe4',
    'dash'
  ),
  (
    '5c2f3854-4eb8-482a-b7ac-47842139da2c',
    'N/A'
  ),
  (
    '3b0d354b-c091-449a-844b-0d64e00e1a24',
    'oz'
  ),
  (
    '679f2e43-f302-4f99-928e-209086a41206',
    'part'
  );

INSERT INTO
  public.ingredients (id, name, weight, image_url)
VALUES
  (
    'a04e3700-5320-48de-a813-2d64bc184faf',
    'Egg White',
    1,
    'https://source.unsplash.com/random/500×500/?egg'
  ),
  (
    '0ecfd3a8-580b-4236-9ac7-02d7c7c1089d',
    'Bourbon',
    2,
    'https://source.unsplash.com/random/500×500/?bourbon'
  ),
  (
    '2cbafcb3-19de-4b00-848e-0979b32ec09e',
    'Angostura Bitters',
    3,
    'https://source.unsplash.com/random/500×500/?bitters'
  ),
  (
    '9e536f62-c639-42af-afec-244f77b155ee',
    'Lemon Zest',
    4,
    'https://source.unsplash.com/random/500×500/?lemon'
  ),
  (
    '82fb793b-0401-402d-a103-6eacde0ac434',
    'Simple Syrup',
    5,
    'https://source.unsplash.com/random/500×500/?sugar'
  );

INSERT INTO
  public.recipes_tags (id, recipe_id, tag_id)
VALUES
  (
    '7e4181cc-53c3-4ee5-9afc-574ccb847470',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    'c2d29867-3d0b-d497-9191-18a9d8ee7830'
  ),
  (
    'ad3766f1-e8d2-43d6-a093-a0734d409b6f',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    'c2b8c518-54ab-4475-b169-891afe039d17'
  );

INSERT INTO
  public.recipes_ingredients (
    id,
    recipe_id,
    ingredient_id,
    unit_id,
    quantity
  )
VALUES
  (
    'adcafa16-a87e-47ce-9870-60e03dcc7f8e',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    'a04e3700-5320-48de-a813-2d64bc184faf',
    '4c403c4c-7eaf-4579-a50c-af0c9a5a05a9',
    30
  ),
  (
    'f9cb17e9-5022-425e-a9ff-526c9547779c',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    '0ecfd3a8-580b-4236-9ac7-02d7c7c1089d',
    '3b0d354b-c091-449a-844b-0d64e00e1a24',
    60
  ),
  (
    'fa9c3b99-a67d-4eeb-906e-20a15f3573ee',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    '2cbafcb3-19de-4b00-848e-0979b32ec09e',
    'b3660fd3-75f2-4e88-a196-eb64b02d8fe4',
    2
  ),
  (
    '63e50e5e-dae3-4bfa-b961-e5cf554e9d9d',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    '9e536f62-c639-42af-afec-244f77b155ee',
    '5c2f3854-4eb8-482a-b7ac-47842139da2c',
    null
  ),
  (
    '7e4181cc-53c3-4ee5-9afc-574ccb847470',
    'f6a16ff7-4a31-11eb-be7b-8344edc8f36b',
    '82fb793b-0401-402d-a103-6eacde0ac434',
    '679f2e43-f302-4f99-928e-209086a41206',
    22.5
  );