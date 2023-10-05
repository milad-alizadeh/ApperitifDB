ALTER TABLE "profiles_recipes" DROP CONSTRAINT "profiles_recipes_profile_id_profiles_id_fk";
--> statement-breakpoint
ALTER TABLE "profiles_recipes" ALTER COLUMN "profile_id" SET NOT NULL;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "profiles_recipes" ADD CONSTRAINT "profiles_recipes_profile_id_profiles_id_fk" FOREIGN KEY ("profile_id") REFERENCES "profiles"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
