import { uuid, pgTable, integer } from 'drizzle-orm/pg-core'
import { createdAt, updatedAt } from '../helpers'
import { recipes } from './recipes'
import { ingredients } from './ingredients'

export const recipesIngredients = pgTable('recipes_ingredients', {
  recipeId: uuid('recipe_id').references(() => recipes.id),
  ingredientId: uuid('ingredient_id').references(() => ingredients.id),
  quantity: integer('quantity'),
  createdAt,
  updatedAt,
})
