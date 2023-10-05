import { uuid, pgTable, primaryKey } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'
import { profiles } from './profiles'
import { recipes } from './recipes'

export const profilesRecipes = pgTable(
  'profiles_recipes',
  {
    profileId: uuid('profile_id')
      .references(() => profiles.id, {
        onDelete: 'cascade',
      })
      .notNull(),
    recipeId: uuid('recipe_id')
      .references(() => recipes.id, {
        onDelete: 'cascade',
      })
      .notNull(),
    createdAt,
    updatedAt,
  },
  (table) => {
    return {
      pk: primaryKey(table.profileId, table.recipeId),
    }
  },
)
