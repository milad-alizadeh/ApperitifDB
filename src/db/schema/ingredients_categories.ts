import { uuid, pgTable } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'
import { ingredients } from './ingredients'
import { categories } from './categories'

export const ingredientsCategories = pgTable('ingredients_categories', {
  id: uuid('id').defaultRandom().primaryKey(),
  ingredientId: uuid('ingredient_id').references(() => ingredients.id),
  categoryId: uuid('category_id').references(() => categories.id),
  createdAt,
  updatedAt,
})
