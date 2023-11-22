alter table profiles enable row level security;

create policy "Users can view their own profile" on profiles for
select
  to authenticated using (auth.uid () = id);