import { uuid, pgTable } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'
import { recipes } from './recipes'
import { categories } from './categories'

export const recipesCategories = pgTable('recipes_categories', {
  id: uuid('id').defaultRandom().primaryKey(),
  recipeId: uuid('recipe_id').references(() => recipes.id),
  categoryId: uuid('category_id').references(() => categories.id),
  createdAt,
  updatedAt,
})
