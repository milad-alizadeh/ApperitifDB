ALTER TABLE "profiles_ingredients" DROP CONSTRAINT "profiles_ingredients_profile_id_profiles_id_fk";
--> statement-breakpoint
ALTER TABLE "profiles_ingredients" ALTER COLUMN "profile_id" SET NOT NULL;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "profiles_ingredients" ADD CONSTRAINT "profiles_ingredients_profile_id_profiles_id_fk" FOREIGN KEY ("profile_id") REFERENCES "profiles"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
