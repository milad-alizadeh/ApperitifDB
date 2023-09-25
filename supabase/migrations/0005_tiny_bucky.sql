ALTER TABLE "profiles" RENAME COLUMN "first_name" TO "name";--> statement-breakpoint
ALTER TABLE "profiles" DROP COLUMN IF EXISTS "last_name";