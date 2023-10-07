create view
  available_recipes_for_profiles as
with
  total_ingredients as (
    select
      recipe_id,
      array_agg(ingredient_id) as all_required_ingredients
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
  )
select
  m.profile_id,
  m.recipe_id,
  m.recipe_name,
  m.matched_ingredients_count,
  array_length(t.all_required_ingredients, 1) as total_required_ingredients,
  round(
    (
      cast(m.matched_ingredients_count as float) / array_length(t.all_required_ingredients, 1)
    ) * 100
  ) as match_percentage,
  case
    when array_length(t.all_required_ingredients, 1) - m.matched_ingredients_count < 2 then true
    else false
  end as almost_makeable,
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
  m.recipe_id,
  m.recipe_name,
  m.matched_ingredients_count,
  t.all_required_ingredients;