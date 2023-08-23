import { uuid, text, pgTable, integer } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'

export const ingredients = pgTable('ingredients', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: text('name'),
  weight: integer('weight'),
  imageUrl: text('image_url'),
  description: text('description'),
  createdAt,
  updatedAt,
})
