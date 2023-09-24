CREATE TABLE IF NOT EXISTS "profiles_ingredients" (
	"profile_id" uuid,
	"ingredient_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT profiles_ingredients_profile_id_ingredient_id PRIMARY KEY("profile_id","ingredient_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "profiles_recipes" (
	"profile_id" uuid,
	"recipe_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT profiles_recipes_profile_id_recipe_id PRIMARY KEY("profile_id","recipe_id")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "profiles_ingredients" ADD CONSTRAINT "profiles_ingredients_profile_id_profiles_id_fk" FOREIGN KEY ("profile_id") REFERENCES "profiles"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "profiles_ingredients" ADD CONSTRAINT "profiles_ingredients_ingredient_id_ingredients_id_fk" FOREIGN KEY ("ingredient_id") REFERENCES "ingredients"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "profiles_recipes" ADD CONSTRAINT "profiles_recipes_profile_id_profiles_id_fk" FOREIGN KEY ("profile_id") REFERENCES "profiles"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "profiles_recipes" ADD CONSTRAINT "profiles_recipes_recipe_id_recipes_id_fk" FOREIGN KEY ("recipe_id") REFERENCES "recipes"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
