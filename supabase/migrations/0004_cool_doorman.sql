ALTER TABLE "categories" ALTER COLUMN "name" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "content_apperitivo" ALTER COLUMN "name" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "equipments" ALTER COLUMN "name" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "ingredients" ALTER COLUMN "name" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "recipes" ALTER COLUMN "name" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "steps" ALTER COLUMN "number" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "steps" ALTER COLUMN "description" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "units" ALTER COLUMN "name" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "profiles" ADD CONSTRAINT "profiles_email_unique" UNIQUE("email");