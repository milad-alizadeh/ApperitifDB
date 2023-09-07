import { uuid, text, pgTable } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'

export const ingredients = pgTable('ingredients', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: text('name'),
  description: text('description'),
  createdAt,
  updatedAt,
})
