import { uuid, pgTable } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'

export const profiles = pgTable('profiles', {
  id: uuid('id').notNull().primaryKey(),
  createdAt,
  updatedAt,
})
