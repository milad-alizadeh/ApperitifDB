create trigger handle_updated_at before
update on recipes for each row
execute procedure moddatetime (updated_at);

create trigger handle_updated_at before
update on categories for each row
execute procedure moddatetime (updated_at);