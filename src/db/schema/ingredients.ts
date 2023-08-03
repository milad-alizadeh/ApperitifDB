import { uuid, text, pgTable, integer } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'

export const ingredients = pgTable('ingredients', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: text('name'),
  unit: text('unit'),
  weight: integer('weight'),
  createdAt,
  updatedAt,
})
