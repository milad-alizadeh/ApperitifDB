import { corsHeaders } from '../_shared/cors.ts'
import { uniqBy } from 'https://raw.githubusercontent.com/lodash/lodash/4.17.21-es/lodash.js'

const POSTHOG_API_KEY = Deno.env.get('POSTHOG_API_KEY') as string
const POSTHOG_DOMAIN = Deno.env.get('POSTHOG_DOMAIN') as string
const POSTHOG_PROJECT_ID = Deno.env.get('POSTHOG_PROJECT_ID') as string

async function queryPosthog(query: { [key: string]: any }): Promise<any> {
  try {
    const params = new URLSearchParams(query)
    const response = await fetch(
      `${POSTHOG_DOMAIN}/api/projects/${POSTHOG_PROJECT_ID}/events/?${params.toString()}`,
      {
        method: 'get',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${POSTHOG_API_KEY}`,
        },
      },
    )

    const data = await response.json()

    return data.results
  } catch (error) {
    console.error('Error fetching user events:', error)
  }
}

async function getUserEvents(userId: string): Promise<any> {
  const recipeViewQuery = {
    distinct_id: userId,
    event: '$screen',
    properties: JSON.stringify([
      {
        key: '$screen_name',
        value: '/recipe',
        operator: 'exact',
        type: 'event',
      },
    ]),
  }

  const recipeViews = await queryPosthog(recipeViewQuery)
  const uniqueRecipeViews = uniqBy(
    recipeViews,
    ({ properties }: any) => properties.recipe_name,
  )

  const ingredientAddQuery = {
    distinct_id: userId,
    event: 'add_ingredients:ingredient_add',
  }
  const ingredientAdd = await queryPosthog(ingredientAddQuery)
  const uniqueIngredientAdd = uniqBy(
    ingredientAdd,
    ({ properties }: any) => properties.ingredient_name,
  )

  return {
    recipeViews: uniqueRecipeViews.length,
    ingredientAdd: uniqueIngredientAdd.length,
  }
}

async function checkUserCriteria(userId: string): Promise<boolean> {
  const { recipeViews, ingredientAdd } = await getUserEvents(userId)

  console.log('recipeViews', recipeViews)
  console.log('ingredientAdd', ingredientAdd)

  const hasViewedRecipe = recipeViews >= 10
  const hasAddedIngredient = ingredientAdd >= 5
  // Check if user has viewed at least 10 recipes or added at least 5 ingredients
  return hasViewedRecipe || hasAddedIngredient
}

Deno.serve(async (req: any) => {
  try {
    // Enable CORS for browser-side requests
    if (req.method === 'OPTIONS') {
      return new Response('ok', { headers: corsHeaders })
    }

    const { userId } = await req.json()

    if (!userId) {
      return new Response('User ID is required', { status: 400 })
    }

    const meetsCriteria = await checkUserCriteria(userId)

    return new Response(JSON.stringify({ showFeedbackWidget: meetsCriteria }), {
      status: 200,
      headers: {
        'Content-Type': 'application/json',
      },
    })
  } catch (error) {
    console.error('Error checking user criteria:', error)
    return new Response('Internal server error', { status: 500 })
  }
})
