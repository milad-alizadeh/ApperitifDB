ALTER TABLE "profiles_recipes" DROP CONSTRAINT "profiles_recipes_recipe_id_recipes_id_fk";
--> statement-breakpoint
ALTER TABLE "profiles_recipes" ALTER COLUMN "recipe_id" SET NOT NULL;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "profiles_recipes" ADD CONSTRAINT "profiles_recipes_recipe_id_recipes_id_fk" FOREIGN KEY ("recipe_id") REFERENCES "recipes"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
