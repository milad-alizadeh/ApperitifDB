import { drizzle } from 'drizzle-orm/postgres-js'
import postgres from 'postgres'
import { recipes } from './db/schema/recipes'
import { faker } from '@faker-js/faker'

const client = postgres(
  'postgresql://postgres:postgres@localhost:54322/postgres',
)
const db = drizzle(client)

const insertRecipes = async (): Promise<void> => {
  const image = faker

  const allRecipes = await db.select().from(recipes)
  console.log(allRecipes, image)
}

insertRecipes()
