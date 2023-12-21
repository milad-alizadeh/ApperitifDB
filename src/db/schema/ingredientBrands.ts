import { uuid, text, pgTable } from 'drizzle-orm/pg-core'
import { ingredients } from './ingredients'
import { createdAt, updatedAt } from '../helpers'

export const ingredientBrands = pgTable('ingredient_brands', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: text('name').notNull(),
  description: text('description'),
  url: text('url'),
  ingredientId: uuid('ingredient_id')
    .references(() => ingredients.id, {
      onDelete: 'cascade',
    })
    .notNull(),
  createdAt,
  updatedAt,
})
