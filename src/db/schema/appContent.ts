import { uuid, text, pgTable, json } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'

export const appContent = pgTable('app_content', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: text('name').notNull(),
  content: json('content'),
  createdAt,
  updatedAt,
})
