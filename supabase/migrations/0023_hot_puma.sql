ALTER TABLE "steps" DROP CONSTRAINT "steps_recipe_id_recipes_id_fk";
--> statement-breakpoint
ALTER TABLE "steps" ALTER COLUMN "recipe_id" SET NOT NULL;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "steps" ADD CONSTRAINT "steps_recipe_id_recipes_id_fk" FOREIGN KEY ("recipe_id") REFERENCES "recipes"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
