drop view if exists ingredients_by_categories;

create view
  ingredients_by_categories as
select
  c.id as id,
  c.name as title,
  json_agg(json_build_object('id', i.id, 'name', i.name)) as data,
  count(i.id) as count
from
  categories c
  join ingredients_categories ic on c.id = ic.category_id
  join ingredients i on i.id = ic.ingredient_id
group by
  c.id
order by
  c.name;

comment on view "ingredients_by_categories" is e'@graphql({"primary_key_columns": ["id"]})';