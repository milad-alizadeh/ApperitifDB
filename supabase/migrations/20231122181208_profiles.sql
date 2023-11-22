alter table profiles enable row level security;

drop policy if exists "Users can view their own profile" on recipes_ingredients;

create policy "Users can view their own profile" on profiles for
select
  to authenticated using (auth.uid () = id);