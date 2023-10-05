ALTER TABLE "ingredients_categories" DROP CONSTRAINT "ingredients_categories_category_id_categories_id_fk";
--> statement-breakpoint
ALTER TABLE "ingredients_categories" ALTER COLUMN "category_id" SET NOT NULL;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "ingredients_categories" ADD CONSTRAINT "ingredients_categories_category_id_categories_id_fk" FOREIGN KEY ("category_id") REFERENCES "categories"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
