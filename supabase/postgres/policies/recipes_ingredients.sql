alter table recipes_ingredients enable row level security;

drop policy if exists "Recipes Ingredients are viewable by everyone." on recipes_ingredients;

create policy "Recipes Ingredients are viewable by everyone." on recipes_ingredients for
select
  to authenticated,
  anon using (true);