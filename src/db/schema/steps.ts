import { uuid, text, integer, pgTable } from 'drizzle-orm/pg-core'
import { recipes } from './recipes'
import { createdAt, updatedAt } from '../helpers'

export const steps = pgTable('steps', {
  id: uuid('id').defaultRandom().primaryKey(),
  recipeId: uuid('recipe_id').references(() => recipes.id),
  number: integer('number'),
  description: text('description'),
  createdAt,
  updatedAt,
})
