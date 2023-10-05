ALTER TABLE "recipes_ingredients" DROP CONSTRAINT "recipes_ingredients_ingredient_id_ingredients_id_fk";
--> statement-breakpoint
ALTER TABLE "recipes_ingredients" ALTER COLUMN "ingredient_id" SET NOT NULL;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "recipes_ingredients" ADD CONSTRAINT "recipes_ingredients_ingredient_id_ingredients_id_fk" FOREIGN KEY ("ingredient_id") REFERENCES "ingredients"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
