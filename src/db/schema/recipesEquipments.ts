import { uuid, pgTable, primaryKey } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'
import { recipes } from './recipes'
import { equipments } from './equipments'

export const recipesEquipments = pgTable(
  'recipes_equipments',
  {
    recipeId: uuid('recipe_id').references(() => recipes.id),
    equipmentId: uuid('equipment_id').references(() => equipments.id),
    createdAt,
    updatedAt,
  },
  (table) => {
    return {
      pk: primaryKey(table.recipeId, table.equipmentId),
    }
  },
)
