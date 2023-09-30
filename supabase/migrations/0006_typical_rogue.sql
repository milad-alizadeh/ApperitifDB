ALTER TABLE "recipes_ingredients" ALTER COLUMN "quantity" SET DATA TYPE numeric(10, 4);--> statement-breakpoint
ALTER TABLE "units" ALTER COLUMN "is_convertable" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "units" ADD COLUMN "plural" text DEFAULT 'ml' NOT NULL;--> statement-breakpoint
ALTER TABLE "units" ADD COLUMN "abbreviation" text NOT NULL;--> statement-breakpoint
ALTER TABLE "units" ADD COLUMN "type" text DEFAULT 'volume' NOT NULL;--> statement-breakpoint
ALTER TABLE "units" ADD COLUMN "system" text DEFAULT 'metric' NOT NULL;--> statement-breakpoint
ALTER TABLE "units" ADD COLUMN "base_unit_id" uuid;--> statement-breakpoint
ALTER TABLE "units" ADD COLUMN "system_to_system_conversion_factor" numeric(10, 6);--> statement-breakpoint
ALTER TABLE "units" ADD COLUMN "base_conversion_factor" numeric(10, 6);--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "units" ADD CONSTRAINT "units_base_unit_id_units_id_fk" FOREIGN KEY ("base_unit_id") REFERENCES "units"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
