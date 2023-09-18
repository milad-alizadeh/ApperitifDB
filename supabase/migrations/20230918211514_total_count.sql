-- Add total count to ingredients_categories table.
comment on table "ingredients_categories" is e'@graphql({"totalCount": {"enabled": true}})';