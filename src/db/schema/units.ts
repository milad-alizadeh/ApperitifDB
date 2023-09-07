import { uuid, pgTable, pgEnum, boolean } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'

const nameEnum = pgEnum('name', [
  'oz',
  'ml',
  'dash',
  'drop',
  'tsp',
  'tbsp',
  'cup',
  'pint',
  'shot',
  'grams',
  'twist',
  'wheel',
  'wedge',
  'pinch',
  'part',
  'rim',
])

export const units = pgTable('units', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: nameEnum('name').default('ml'),
  isConvertable: boolean('is_convertable').default(false),
  createdAt,
  updatedAt,
})
