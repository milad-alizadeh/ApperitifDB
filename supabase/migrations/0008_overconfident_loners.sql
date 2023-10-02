ALTER TABLE "equipments" RENAME TO "equipment";--> statement-breakpoint
ALTER TABLE "recipes_equipments" RENAME TO "recipes_equipment";--> statement-breakpoint
ALTER TABLE "recipes_equipment" DROP CONSTRAINT "recipes_equipments_recipe_id_recipes_id_fk";
--> statement-breakpoint
ALTER TABLE "recipes_equipment" DROP CONSTRAINT "recipes_equipments_equipment_id_equipments_id_fk";
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "recipes_equipment" ADD CONSTRAINT "recipes_equipment_recipe_id_recipes_id_fk" FOREIGN KEY ("recipe_id") REFERENCES "recipes"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "recipes_equipment" ADD CONSTRAINT "recipes_equipment_equipment_id_equipment_id_fk" FOREIGN KEY ("equipment_id") REFERENCES "equipment"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
