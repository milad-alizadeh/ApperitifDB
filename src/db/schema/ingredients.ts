import { uuid, text, pgTable, boolean } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'

export const ingredients = pgTable('ingredients', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: text('name').notNull(),
  description: text('description'),
  isDraft: boolean('is_draft').default(false),
  createdAt,
  updatedAt,
})
