import { uuid, text, pgTable, json } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'

export const contentApperitivo = pgTable('content_apperitivo', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: text('name'),
  content: json('content'),
  createdAt,
  updatedAt,
})
