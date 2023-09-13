-- Add influxion to the public schema
comment on schema public is e'@graphql({"inflect_names": true})';