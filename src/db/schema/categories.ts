import { uuid, text, pgTable } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'

export const categories = pgTable('categories', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: text('name'),
  parentId: uuid('parent_id').references(() => categories.id),
  createdAt,
  updatedAt,
})
