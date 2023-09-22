import { uuid, text, pgTable } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'

export const profiles = pgTable('profiles', {
  id: uuid('id').notNull().primaryKey(),
  firstName: text('first_name'),
  lastName: text('last_name'),
  email: text('email'),
  createdAt,
  updatedAt,
})
