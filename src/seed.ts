import { drizzle } from 'drizzle-orm/postgres-js'
import postgres from 'postgres'
import { recipes } from './db/schema/recipes'
import { categories } from './db/schema/categories'
import { ingredients } from './db/schema/ingredients'
import recipesData from './seedData/recipes'
import categoriesData from './seedData/categories'
import ingredientsData from './seedData/ingredients'

const client = postgres(
  'postgresql://postgres:postgres@localhost:54322/postgres',
)
const db = drizzle(client)

const insertData = async (): Promise<void> => {
  const insertedRecipes = await db
    .insert(recipes)
    .values(recipesData)
    .returning()
  const insertedCategories = await db
    .insert(categories)
    .values(categoriesData)
    .returning()
  const insertedIngredients = await db
    .insert(ingredients)
    .values(ingredientsData)
    .returning()
  console.log(insertedRecipes)
  console.log(insertedCategories)
  console.log(insertedIngredients)
}

export default (): void => {
  insertData()
}
