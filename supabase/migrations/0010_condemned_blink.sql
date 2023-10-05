ALTER TABLE "recipes_categories" DROP CONSTRAINT "recipes_categories_recipe_id_recipes_id_fk";
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "recipes_categories" ADD CONSTRAINT "recipes_categories_recipe_id_recipes_id_fk" FOREIGN KEY ("recipe_id") REFERENCES "recipes"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
