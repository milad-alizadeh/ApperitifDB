alter view available_recipes_for_profiles enable row level security;

create policy "Users can view their recommended recipes." on available_recipes_for_profiles for
select
  using (auth.uid () = profile_id)