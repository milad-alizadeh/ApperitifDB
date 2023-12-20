drop view if exists my_bar;

create view
  my_bar
with
  (security_invoker) as
select
  c.id as id,
  c.name as title,
  json_agg(
    json_build_object('id', i.id, 'name', i.name)
    order by
      i.name
  ) filter (
    where
      pi.profile_id = auth.uid ()
  ) as data,
  count(i.id) filter (
    where
      pi.profile_id = auth.uid ()
  ) as count
from
  categories c
  join ingredients_categories ic on c.id = ic.category_id
  join ingredients i on ic.ingredient_id = i.id
  join profiles_ingredients pi on pi.ingredient_id = i.id
where
  pi.profile_id = auth.uid ()
group by
  c.id;

comment on view "my_bar" is e'@graphql({"primary_key_columns": ["id"]})';