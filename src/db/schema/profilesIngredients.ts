import { uuid, pgTable, primaryKey } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'
import { profiles } from './profiles'
import { ingredients } from './ingredients'

export const profilesIngredients = pgTable(
  'profiles_ingredients',
  {
    profileId: uuid('profile_id')
      .references(() => profiles.id, {
        onDelete: 'cascade',
      })
      .notNull(),
    ingredientId: uuid('ingredient_id')
      .references(() => ingredients.id, {
        onDelete: 'cascade',
      })
      .notNull(),
    createdAt,
    updatedAt,
  },
  (table) => {
    return {
      pk: primaryKey(table.profileId, table.ingredientId),
    }
  },
)
