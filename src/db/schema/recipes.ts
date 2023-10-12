import { uuid, text, pgTable, boolean } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'

export const recipes = pgTable('recipes', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: text('name').notNull(),
  imageUrl: text('image_url'),
  description: text('description'),
  isDraft: boolean('is_draft').default(false),
  createdAt,
  updatedAt,
})
