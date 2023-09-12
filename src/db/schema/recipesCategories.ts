import { uuid, pgTable, primaryKey } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'
import { recipes } from './recipes'
import { categories } from './categories'

export const recipesCategories = pgTable(
  'recipes_categories',
  {
    recipeId: uuid('recipe_id').references(() => recipes.id),
    categoryId: uuid('category_id').references(() => categories.id),
    createdAt,
    updatedAt,
  },
  (table) => {
    return {
      pk: primaryKey(table.recipeId, table.categoryId),
    }
  },
)
