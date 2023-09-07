ALTER TABLE "recipes_ingredients" ALTER COLUMN "type" SET DEFAULT 'essential';--> statement-breakpoint
ALTER TABLE "units" ALTER COLUMN "name" SET DEFAULT 'ml';--> statement-breakpoint
ALTER TABLE "units" ADD COLUMN "is_convertable" boolean DEFAULT false;--> statement-breakpoint
ALTER TABLE "ingredients" DROP COLUMN IF EXISTS "weight";--> statement-breakpoint
ALTER TABLE "ingredients" DROP COLUMN IF EXISTS "image_url";