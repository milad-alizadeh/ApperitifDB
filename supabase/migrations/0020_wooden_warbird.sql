ALTER TABLE "recipes_ingredients" DROP CONSTRAINT "recipes_ingredients_recipe_id_recipes_id_fk";
--> statement-breakpoint
ALTER TABLE "recipes_ingredients" ALTER COLUMN "recipe_id" SET NOT NULL;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "recipes_ingredients" ADD CONSTRAINT "recipes_ingredients_recipe_id_recipes_id_fk" FOREIGN KEY ("recipe_id") REFERENCES "recipes"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
