import { drizzle } from 'drizzle-orm/postgres-js'
import postgres from 'postgres'
import { recipes } from './db/schema/recipes'
import { categories } from './db/schema/categories'
import { ingredients } from './db/schema/ingredients'
import { units } from './db/schema/units'
import { recipesIngredients } from './db/schema/recipesIngredients'
import { recipesCategories } from './db/schema/recipesCategories'
import { steps } from './db/schema/steps'
import { contentApperitivo } from './db/schema/contentApperitivo'
import recipesData from './seedData/recipes'
import categoriesData from './seedData/categories'
import parentCategoriesData from './seedData/parentCategories'
import ingredientsData from './seedData/ingredients'
import sampleSize from 'lodash/sampleSize'
import sample from 'lodash/sample'
import unitsData from './seedData/units'
import quantities from './seedData/quantities'
import stepsData from './seedData/steps'
import { eq } from 'drizzle-orm'

const client = postgres(
  'postgresql://postgres:postgres@localhost:54322/postgres',
)

const db = drizzle(client)

const insertData = async (): Promise<void> => {
  // Recipes
  const insertedRecipes = await db
    .insert(recipes)
    .values(recipesData)
    .returning()

  // Parent Categories
  const insertedParentCategories = await db
    .insert(categories)
    .values(parentCategoriesData)
    .returning()

  // Categories
  const insertedCategories = await db
    .insert(categories)
    .values(categoriesData)
    .returning()

  // Ingredients
  const insertedIngredients = await db
    .insert(ingredients)
    .values(ingredientsData)
    .returning()

  // Units
  const insertedUnits = await db.insert(units).values(unitsData).returning()

  // Recipes
  seedRecipes(insertedRecipes, insertedIngredients, insertedUnits)

  // Recipe Categories
  seedCategories(insertedRecipes, insertedCategories, insertedParentCategories)

  // Content
  seedContent(insertedParentCategories)
}

async function seedCategories(
  insertedRecipes,
  insertedCategories,
  insertedParentCategories,
): Promise<void> {
  const insetRecipCategories = (
    start: number,
    end: number,
    parentId: number,
  ): void => {
    insertedCategories.slice(start, end).forEach(async (category) => {
      await db
        .update(categories)
        .set({ parentId })
        .where(eq(categories.id, category.id))

      sampleSize(insertedRecipes, 10).forEach(async (recipe) => {
        const recipesCategoriesData = {
          recipeId: recipe.id,
          categoryId: category.id,
          type: sample(['essential', 'optional']),
        }
        await db
          .insert(recipesCategories)
          .values(recipesCategoriesData)
          .returning()
      })
    })
  }

  // Parent Categories
  insetRecipCategories(0, 9, insertedParentCategories[0].id)
  insetRecipCategories(10, 19, insertedParentCategories[1].id)
  insetRecipCategories(20, 29, insertedParentCategories[2].id)

  // Top Picks
  sampleSize(insertedRecipes, 10).forEach(async (recipe) => {
    const recipesCategoriesData = {
      recipeId: recipe.id,
      categoryId: insertedParentCategories[3].id,
      parentId: null,
      type: sample(['essential', 'optional']),
    }
    await db.insert(recipesCategories).values(recipesCategoriesData).returning()
  })
}

async function seedContent(parentCategories): Promise<void> {
  // Seed with the order of Top Picks, Mood, Base Spirit, Flavour
  const homeContent = {
    categories: [
      parentCategories[3].id,
      parentCategories[0].id,
      parentCategories[2].id,
      parentCategories[1].id,
    ],
  }

  const filterContent = {
    filters: [
      parentCategories[0].id,
      parentCategories[2].id,
      parentCategories[1].id,
    ],
  }

  await db
    .insert(contentApperitivo)
    .values({ name: 'home', content: homeContent })
    .returning()

  await db
    .insert(contentApperitivo)
    .values({ name: 'filters', content: filterContent })
    .returning()
}

async function seedRecipes(
  insertedRecipes,
  insertedIngredients,
  insertedUnits,
): Promise<void> {
  insertedRecipes.forEach(async (recipe) => {
    // Steps
    sampleSize(stepsData, 4).forEach(async (step, index) => {
      const stepsData = {
        recipeId: recipe.id,
        number: index + 1,
        description: step.description,
      }
      await db.insert(steps).values(stepsData).returning()
    })

    sampleSize(insertedIngredients, 4).forEach(async (ingredient) => {
      const recipeIngredientsData = {
        recipeId: recipe.id,
        ingredientId: ingredient.id,
        unitId: sample(insertedUnits).id,
        quantity: sample(quantities),
        type: sample(['essential', 'optional']),
      }

      // Recipe Ingredients
      await db
        .insert(recipesIngredients)
        .values(recipeIngredientsData)
        .returning()
    })
  })
}

async function seedData(): Promise<void> {
  console.log('seeding data started')
  insertData()
  console.log('seeding data finished')
}

seedData()
