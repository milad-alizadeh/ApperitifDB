ALTER TABLE "ingredients_categories" DROP CONSTRAINT "ingredients_categories_ingredient_id_ingredients_id_fk";
--> statement-breakpoint
ALTER TABLE "ingredients_categories" ALTER COLUMN "ingredient_id" SET NOT NULL;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "ingredients_categories" ADD CONSTRAINT "ingredients_categories_ingredient_id_ingredients_id_fk" FOREIGN KEY ("ingredient_id") REFERENCES "ingredients"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
