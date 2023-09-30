import { uuid, pgTable, boolean, text, numeric } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'

export const units = pgTable('units', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: text('name').notNull(),
  plural: text('plural').notNull(),
  abbreviation: text('abbreviation').notNull(),
  type: text('type').notNull().default('volume'),
  system: text('system').notNull().default('metric'),
  isConvertable: boolean('is_convertable').default(false).notNull(),
  baseUnitId: uuid('base_unit_id').references(() => units.id),
  systemToSystemConversionFactor: numeric(
    'system_to_system_conversion_factor',
    {
      precision: 10,
      scale: 6,
    },
  ),
  baseConversionFactor: numeric('base_conversion_factor', {
    precision: 10,
    scale: 6,
  }),
  createdAt,
  updatedAt,
})
