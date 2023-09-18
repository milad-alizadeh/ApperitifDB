import { uuid, text, pgTable } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'

export const equipments = pgTable('equipments', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: text('name'),
  description: text('description'),
  imageUrl: text('image_url'),
  createdAt,
  updatedAt,
})
