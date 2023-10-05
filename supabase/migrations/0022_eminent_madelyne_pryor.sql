ALTER TABLE "recipes_ingredients" DROP CONSTRAINT "recipes_ingredients_unit_id_units_id_fk";
--> statement-breakpoint
ALTER TABLE "recipes_ingredients" ALTER COLUMN "unit_id" SET NOT NULL;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "recipes_ingredients" ADD CONSTRAINT "recipes_ingredients_unit_id_units_id_fk" FOREIGN KEY ("unit_id") REFERENCES "units"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
