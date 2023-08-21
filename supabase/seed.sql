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
  ),
  (
    '5c6914d1-d898-40d4-abb7-44b862967245',
    'Mojito',
    'https://source.unsplash.com/random/500x500/?mojito'
  ),
  (
    'c77587f4-b5ce-4987-9562-636202b52f30',
    'Margarita',
    'https://source.unsplash.com/random/500x500/?margarita'
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
  ),
  (
    '4efa4080-d466-4933-9810-5eb5e8f6f5d0',
    '5c6914d1-d898-40d4-abb7-44b862967245',
    1,
    'In a glass muddle the lime, sugar and mint leaves.'
  ),
  (
    '2b7c3d76-a10e-4f4c-a4c3-c4dc4cb11490',
    '5c6914d1-d898-40d4-abb7-44b862967245',
    2,
    'Add rum and top with soda. Stir gently.'
  ),
  (
    '1f3d08d6-5970-4621-81d9-36518d45713e',
    '5c6914d1-d898-40d4-abb7-44b862967245',
    3,
    'Fill glass with ice and garnish with mint.'
  ),
  (
    '6cbc7b3a-0b15-4b25-b8ba-4762e933efe3',
    'c77587f4-b5ce-4987-9562-636202b52f30',
    1,
    'Rim half the glass with salt.'
  ),
  (
    '8569551c-a8c3-47b1-9cc7-79dc3cb41adc',
    'c77587f4-b5ce-4987-9562-636202b52f30',
    2,
    'Fill a cocktail shaker with ice. Add tequila, orange liqueur and lime juice. Shake well.'
  ),
  (
    '0c747927-8a8f-4b09-86d8-f65b8e61842a',
    'c77587f4-b5ce-4987-9562-636202b52f30',
    3,
    'Strain into the prepared glass filled with ice. Garnish with lime wedge.'
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
  ),
  (
    'c1a8a30d-b6e6-47e0-9d26-84a3b5d533d3',
    'Lime',
    6,
    'https://source.unsplash.com/random/500x500/?lime'
  ),
  (
    'a2a2e23d-c095-420c-b9b0-e1493a7d35d3',
    'Mint',
    7,
    'https://source.unsplash.com/random/500x500/?mint'
  ),
  (
    '53655728-9114-4db4-af07-e28da6e24edd',
    'Light Rum',
    8,
    'https://source.unsplash.com/random/500x500/?rum'
  ),
  (
    'c9bf47cf-063a-4188-8ae9-2e98f5150e49',
    'Club Soda',
    9,
    'https://source.unsplash.com/random/500x500/?soda'
  ),
  (
    'edf391a5-f3b0-4325-9318-c0d64d78d0d5',
    'Tequila',
    10,
    'https://source.unsplash.com/random/500x500/?tequila'
  ),
  (
    '1f8d8a96-8e80-4c44-b8f2-8044be2d3b09',
    'Orange Liqueur',
    11,
    'https://source.unsplash.com/random/500x500/?orange-liqueur'
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
  ),
  (
    '9e9c2eab-8622-4b1b-a545-4a4671000bb3',
    '5c6914d1-d898-40d4-abb7-44b862967245',
    'c2b8c518-54ab-4475-b169-891afe039d17'
  ),
  (
    'c081c6b3-2600-4b69-bd09-9ebeaa3c8bd6',
    'c77587f4-b5ce-4987-9562-636202b52f30',
    '4acb9163-4149-47e2-b98a-2e84b74c711e'
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
  ),
  (
    '8b7ae817-7c0d-47e5-a24e-5c805c44968c',
    '5c6914d1-d898-40d4-abb7-44b862967245',
    'c1a8a30d-b6e6-47e0-9d26-84a3b5d533d3',
    '4c403c4c-7eaf-4579-a50c-af0c9a5a05a9',
    1
  ),
  (
    'ea2504a7-1e36-418d-bee7-b326fae8e236',
    '5c6914d1-d898-40d4-abb7-44b862967245',
    'a2a2e23d-c095-420c-b9b0-e1493a7d35d3',
    '5c2f3854-4eb8-482a-b7ac-47842139da2c',
    3
  ),
  (
    '6f685324-2096-4ccd-a1c3-ba78e1076f6b',
    '5c6914d1-d898-40d4-abb7-44b862967245',
    '53655728-9114-4db4-af07-e28da6e24edd',
    '3b0d354b-c091-449a-844b-0d64e00e1a24',
    1.5
  ),
  (
    '91c9ddd1-92f4-4ac2-9567-3d29ae2a61f4',
    '5c6914d1-d898-40d4-abb7-44b862967245',
    'c9bf47cf-063a-4188-8ae9-2e98f5150e49',
    '4c403c4c-7eaf-4579-a50c-af0c9a5a05a9',
    120
  ),
  (
    '856ce10a-5e24-4af0-b9dc-0b58d96ad9be',
    'c77587f4-b5ce-4987-9562-636202b52f30',
    'edf391a5-f3b0-4325-9318-c0d64d78d0d5',
    '3b0d354b-c091-449a-844b-0d64e00e1a24',
    1.5
  ),
  (
    '328867ab-25e2-42bb-9663-1d2df6baf050',
    'c77587f4-b5ce-4987-9562-636202b52f30',
    '1f8d8a96-8e80-4c44-b8f2-8044be2d3b09',
    '4c403c4c-7eaf-4579-a50c-af0c9a5a05a9',
    30
  ),
  (
    '2e215a72-ad9b-4888-aea0-57e7a867217c',
    'c77587f4-b5ce-4987-9562-636202b52f30',
    'c1a8a30d-b6e6-47e0-9d26-84a3b5d533d3',
    '4c403c4c-7eaf-4579-a50c-af0c9a5a05a9',
    30
  );