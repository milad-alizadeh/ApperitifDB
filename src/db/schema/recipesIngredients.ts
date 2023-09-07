import { uuid, pgTable, text, real } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'
import { recipes } from './recipes'
import { ingredients } from './ingredients'
import { units } from './units'

export const recipesIngredients = pgTable('recipes_ingredients', {
  id: uuid('id').defaultRandom().primaryKey(),
  recipeId: uuid('recipe_id').references(() => recipes.id),
  ingredientId: uuid('ingredient_id').references(() => ingredients.id),
  quantity: real('quantity'),
  unitId: uuid('unit_id').references(() => units.id),
  type: text('type').default('essential'),
  createdAt,
  updatedAt,
})