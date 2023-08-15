import {
  GraphQLObjectType,
  GraphQLString,
  GraphQLInt,
  GraphQLSchema,
  GraphQLList,
} from 'graphql'
import { db } from '../db'
import { ingredients, recipes, steps } from '../db/schema'
import { eq } from 'drizzle-orm'

const IngredientType = new GraphQLObjectType({
  name: 'Ingredient',
  fields: {
    id: { type: GraphQLString },
    name: { type: GraphQLString },
    weight: { type: GraphQLInt },
    imageUrl: { type: GraphQLString },
    createdAt: { type: GraphQLString },
    updatedAt: { type: GraphQLString },
  },
})

const StepType = new GraphQLObjectType({
  name: 'Steps',
  fields: () => ({
    id: { type: GraphQLString },
    number: { type: GraphQLString },
    description: { type: GraphQLString },
    recipe: {
      type: RecipeType,
      resolve: async (parent) => {
        return db
          .select()
          .from(recipes)
          .where(eq(recipes.id, parent.recipeId))
          .then((res) => res[0])
      },
    },
    createdAt: { type: GraphQLString },
    updatedAt: { type: GraphQLString },
  }),
})

const RecipeType = new GraphQLObjectType({
  name: 'Recipe',
  fields: () => ({
    id: { type: GraphQLString },
    name: { type: GraphQLString },
    steps: {
      type: new GraphQLList(StepType),
      resolve: async (parent) => {
        return db.select().from(steps).where(eq(steps.recipeId, parent.id))
      },
    },
    imageUrl: { type: GraphQLString },
    createdAt: { type: GraphQLString },
    updatedAt: { type: GraphQLString },
  }),
})

const RootQuery = new GraphQLObjectType({
  name: 'RootQueryType',
  fields: {
    ingredient: {
      type: IngredientType,
      args: { id: { type: GraphQLString } },
      resolve: async (_parent, args: any): Promise<any> => {
        return db
          .select()
          .from(ingredients)
          .where(eq(ingredients.id, args.id))
          .then((res) => res[0])
      },
    },
    recipes: {
      type: RecipeType,
      args: { id: { type: GraphQLString } },
      resolve: async (_parent, args: any): Promise<any> => {
        return db
          .select()
          .from(recipes)
          .where(eq(recipes.id, args.id))
          .then((res) => res[0])
      },
    },
    steps: {
      type: StepType,
      args: { id: { type: GraphQLString } },
      resolve: async (_parent, args: any): Promise<any> => {
        return db
          .select()
          .from(steps)
          .where(eq(steps.id, args.id))
          .then((res) => res[0])
      },
    },
  },
})

export const schema = new GraphQLSchema({
  query: RootQuery,
})
