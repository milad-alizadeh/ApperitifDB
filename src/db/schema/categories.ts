import { uuid, text, pgTable } from 'drizzle-orm/pg-core'
import { createdAt } from '../helpers'

export const categories = pgTable('categories', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: text('name'),
  createdAt,
})
