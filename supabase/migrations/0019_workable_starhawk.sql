ALTER TABLE "recipes_equipment" DROP CONSTRAINT "recipes_equipment_equipment_id_equipment_id_fk";
--> statement-breakpoint
ALTER TABLE "recipes_equipment" ALTER COLUMN "equipment_id" SET NOT NULL;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "recipes_equipment" ADD CONSTRAINT "recipes_equipment_equipment_id_equipment_id_fk" FOREIGN KEY ("equipment_id") REFERENCES "equipment"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
