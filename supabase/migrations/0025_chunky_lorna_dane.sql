ALTER TABLE "profiles" DROP CONSTRAINT "profiles_email_unique";--> statement-breakpoint
ALTER TABLE "profiles" DROP COLUMN IF EXISTS "name";--> statement-breakpoint
ALTER TABLE "profiles" DROP COLUMN IF EXISTS "email";