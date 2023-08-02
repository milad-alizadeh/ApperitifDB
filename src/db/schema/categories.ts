import { uuid, text, pgTable } from 'drizzle-orm/pg-core'

export const categories = pgTable('categories', {
  id: uuid('id').primaryKey(),
  name: text('name'),
})
