drop view if exists ingredients_by_categories;

create view
  ingredients_by_categories
with
  (security_invoker) as
select
  c.id as id,
  c.name as title,
  json_agg(
    json_build_object('id', ing.id, 'name', ing.name)
    order by
      ing.name
  ) as data,
  count(ing.id) as count
from
  categories c
  join ingredients_categories ic on c.id = ic.category_id
  join (
    select
      i.id,
      i.name
    from
      ingredients i
    order by
      i.name
  ) as ing on ing.id = ic.ingredient_id
group by
  c.id
order by
  c.name;

comment on view "ingredients_by_categories" is e'@graphql({"primary_key_columns": ["id"]})';