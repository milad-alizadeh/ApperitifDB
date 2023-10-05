import {
  uuid,
  pgTable,
  primaryKey,
  boolean,
  numeric,
} from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'
import { recipes } from './recipes'
import { ingredients } from './ingredients'
import { units } from './units'

export const recipesIngredients = pgTable(
  'recipes_ingredients',
  {
    recipeId: uuid('recipe_id')
      .references(() => recipes.id, {
        onDelete: 'cascade',
      })
      .notNull(),
    ingredientId: uuid('ingredient_id')
      .references(() => ingredients.id, {
        onDelete: 'cascade',
      })
      .notNull(),
    quantity: numeric('quantity', { precision: 10, scale: 4 }),
    unitId: uuid('unit_id').references(() => units.id, {
      onDelete: 'cascade',
    }),
    isOptional: boolean('is_optional').default(false),
    createdAt,
    updatedAt,
  },
  (table) => {
    return {
      pk: primaryKey(table.recipeId, table.ingredientId),
    }
  },
)
