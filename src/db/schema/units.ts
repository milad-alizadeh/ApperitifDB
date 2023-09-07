import { uuid, pgTable, boolean, text } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'

export const units = pgTable('units', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: text('name').default('ml'),
  isConvertable: boolean('is_convertable').default(false),
  createdAt,
  updatedAt,
})
