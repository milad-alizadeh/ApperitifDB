import { uuid, pgTable, text } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'

export const profiles = pgTable('profiles', {
  id: uuid('id').notNull().primaryKey(),
  role: text('role').notNull().default('user'),
  createdAt,
  updatedAt,
})
