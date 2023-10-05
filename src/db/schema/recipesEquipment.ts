import { uuid, pgTable, primaryKey } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'
import { recipes } from './recipes'
import { equipment } from './equipment'

export const recipesEquipment = pgTable(
  'recipes_equipment',
  {
    recipeId: uuid('recipe_id')
      .references(() => recipes.id, {
        onDelete: 'cascade',
      })
      .notNull(),
    equipmentId: uuid('equipment_id')
      .references(() => equipment.id, {
        onDelete: 'cascade',
      })
      .notNull(),
    createdAt,
    updatedAt,
  },
  (table) => {
    return {
      pk: primaryKey(table.recipeId, table.equipmentId),
    }
  },
)
