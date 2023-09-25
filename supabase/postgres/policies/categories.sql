drop policy if exists "Categories are viewable by everyone." on categories;

create policy "Categories are viewable by everyone." on categories for
select
  using (true);