alter table ingredients_categories enable row level security;

drop policy if exists "Ingredients Categories are viewable by everyone." on ingredients_categories;

create policy "Ingredients Categories are viewable by everyone." on ingredients_categories for
select
  to authenticated,
  anon using (true);