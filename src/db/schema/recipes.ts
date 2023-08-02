import { uuid, text, pgTable } from 'drizzle-orm/pg-core'
import { categories } from './categories'

export const recipes = pgTable('recipes', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: text('name'),
  categoryId: uuid('category_id').references(() => categories.id),
  imageUrl: text('image_url'),
})
