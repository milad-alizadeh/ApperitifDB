create or replace view
  available_recipes_for_profiles as
with
  total_ingredients as (
    select
      recipe_id,
      array_agg(ingredient_id) as all_required_ingredients,
      count(*) as total_required_count
    from
      recipes_ingredients
    where
      is_optional = false
    group by
      recipe_id
  ),
  matched_ingredients as (
    select
      p.id as profile_id,
      r.id as recipe_id,
      r.name as recipe_name,
      array_agg(pi.ingredient_id) as matched_ingredients_array,
      count(pi.ingredient_id) as matched_ingredients_count
    from
      profiles p
      join profiles_ingredients pi on p.id = pi.profile_id
      join recipes_ingredients ri on pi.ingredient_id = ri.ingredient_id
      and ri.is_optional = false
      join recipes r on ri.recipe_id = r.id
    group by
      p.id,
      r.id,
      r.name
  ),
  missing_ingredients_data as (
    select
      m.profile_id,
      m.recipe_id,
      array_to_json(
        array_agg(json_build_object('id', ing.id, 'name', ing.name))
      ) as missing_ingredients
    from
      matched_ingredients m
      join total_ingredients t on m.recipe_id = t.recipe_id
      left join ingredients ing on ing.id = any (t.all_required_ingredients)
    where
      not ing.id = any (m.matched_ingredients_array)
    group by
      m.profile_id,
      m.recipe_id
  )
select
  m.profile_id,
  m.recipe_id,
  m.recipe_name,
  m.matched_ingredients_count,
  t.total_required_count,
  m.matched_ingredients_count = t.total_required_count as is_total_match,
  case
    when t.total_required_count - m.matched_ingredients_count < 2 then true
    else false
  end as can_almost_make,
  mid.missing_ingredients
from
  matched_ingredients m
  join total_ingredients t on m.recipe_id = t.recipe_id
  left join missing_ingredients_data mid on m.profile_id = mid.profile_id
  and m.recipe_id = mid.recipe_id;

comment on view "available_recipes_for_profiles" is e'@graphql({"primary_key_columns": ["profile_id", "recipe_id"]})';