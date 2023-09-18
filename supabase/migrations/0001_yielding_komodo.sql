CREATE TABLE IF NOT EXISTS "equipments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text,
	"description" text,
	"imageUrl" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "recipes_equipments" (
	"recipe_id" uuid,
	"equipment_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT recipes_equipments_recipe_id_equipment_id PRIMARY KEY("recipe_id","equipment_id")
);
--> statement-breakpoint
ALTER TABLE "recipes_ingredients" RENAME COLUMN "type" TO "isOptional";--> statement-breakpoint
ALTER TABLE "recipes_ingredients" ALTER COLUMN "isOptional" SET DATA TYPE boolean;--> statement-breakpoint
ALTER TABLE "recipes_ingredients" ALTER COLUMN "isOptional" SET DEFAULT false;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "recipes_equipments" ADD CONSTRAINT "recipes_equipments_recipe_id_recipes_id_fk" FOREIGN KEY ("recipe_id") REFERENCES "recipes"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "recipes_equipments" ADD CONSTRAINT "recipes_equipments_equipment_id_equipments_id_fk" FOREIGN KEY ("equipment_id") REFERENCES "equipments"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
