alter table recipes_categories enable row level security;

drop policy if exists "Recipes Categories are viewable by everyone." on recipes_categories;

create policy "Recipes Categories are viewable by everyone." on recipes_categories for
select
  to authenticated,
  anon using (true);