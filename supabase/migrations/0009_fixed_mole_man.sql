ALTER TABLE "ingredients_categories" DROP COLUMN IF EXISTS "id";--> statement-breakpoint
ALTER TABLE "recipes_categories" DROP COLUMN IF EXISTS "id";--> statement-breakpoint
ALTER TABLE "recipes_ingredients" DROP COLUMN IF EXISTS "id";--> statement-breakpoint
ALTER TABLE "ingredients_categories" ADD CONSTRAINT "ingredients_categories_ingredient_id_category_id" PRIMARY KEY("ingredient_id","category_id");--> statement-breakpoint
ALTER TABLE "recipes_categories" ADD CONSTRAINT "recipes_categories_recipe_id_category_id" PRIMARY KEY("recipe_id","category_id");--> statement-breakpoint
ALTER TABLE "recipes_ingredients" ADD CONSTRAINT "recipes_ingredients_recipe_id_ingredient_id" PRIMARY KEY("recipe_id","ingredient_id");