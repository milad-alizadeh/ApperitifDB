import { uuid, pgTable, primaryKey } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'
import { ingredients } from './ingredients'
import { categories } from './categories'

export const ingredientsCategories = pgTable(
  'ingredients_categories',
  {
    ingredientId: uuid('ingredient_id')
      .references(() => ingredients.id, {
        onDelete: 'cascade',
      })
      .notNull(),
    categoryId: uuid('category_id')
      .references(() => categories.id, {
        onDelete: 'cascade',
      })
      .notNull(),
    createdAt,
    updatedAt,
  },
  (table) => {
    return {
      pk: primaryKey(table.ingredientId, table.categoryId),
    }
  },
)
