import { drizzle } from 'drizzle-orm/postgres-js'
import postgres from 'postgres'
import { recipes } from './db/schema/recipes'
import { categories } from './db/schema/categories'
import { ingredients } from './db/schema/ingredients'
import { units } from './db/schema/units'
import recipesData from './seedData/recipes'
import categoriesData from './seedData/categories'
import ingredientsData from './seedData/ingredients'
import sampleSize from 'lodash/sampleSize'
import sample from 'lodash/sample'
import unitsData from './seedData/units'
import quantities from './seedData/quantities'
import { recipesIngredients } from './db/schema/recipesIngredients'
import { migrate } from 'drizzle-orm/postgres-js/migrator'

const client = postgres(
  'postgresql://postgres:postgres@localhost:54322/postgres',
)

const db = drizzle(client)

const insertData = async (): Promise<void> => {
  // this will automatically run needed migrations on the database
  await migrate(db, { migrationsFolder: './supabase/migrations' })

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

  const insertedUnits = await db.insert(units).values(unitsData).returning()

  insertedRecipes.forEach(async (recipe) => {
    const recipeIngredientsData = {
      recipeId: recipe.id,
      ingredientId: sampleSize(insertedIngredients, 4).map(
        (ingredient) => ingredient.id,
      ),
      unit: sample(insertedUnits),
      quantity: sample(quantities),
      type: sample(['essential', 'optional']),
    }

    const insertedRecipeIngredients = await db
      .insert(recipesIngredients)
      .values(recipeIngredientsData)
      .returning()

    console.log(insertedRecipeIngredients)
  })

  console.log(insertedRecipes)
  console.log(insertedCategories)
  console.log(insertedIngredients)
}

export default (): void => {
  insertData()
}
