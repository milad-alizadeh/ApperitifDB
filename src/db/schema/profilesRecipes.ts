import { uuid, pgTable, primaryKey } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'
import { profiles } from './profiles'
import { recipes } from './recipes'

export const profilesRecipes = pgTable(
  'profiles_recipes',
  {
    profileId: uuid('profile_id').references(() => profiles.id),
    recipeId: uuid('recipe_id').references(() => recipes.id),
    createdAt,
    updatedAt,
  },
  (table) => {
    return {
      pk: primaryKey(table.profileId, table.recipeId),
    }
  },
)
