import { uuid, text, pgTable } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'

export const units = pgTable('units', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: text('name'),
  createdAt,
  updatedAt,
})
