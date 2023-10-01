ALTER TABLE "content_apperitivo" RENAME TO "app_content";--> statement-breakpoint
ALTER TABLE "units" ALTER COLUMN "name" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "units" ALTER COLUMN "plural" DROP DEFAULT;