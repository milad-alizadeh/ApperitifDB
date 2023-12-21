-- Add total count to ingredients_categories table.
comment on table "ingredients_categories" is e'@graphql({"totalCount": {"enabled": true}})';

comment on table "ingredients" is e'@graphql({"totalCount": {"enabled": true}})';

comment on table "recipes" is e'@graphql({"totalCount": {"enabled": true}})';

comment on table "categories" is e'@graphql({"totalCount": {"enabled": true}})';

comment on table "equipment" is e'@graphql({"totalCount": {"enabled": true}})';

comment on table "app_content" is e'@graphql({"totalCount": {"enabled": true}})';

comment on table "ingredient_brands" is e'@graphql({"totalCount": {"enabled": true}})';