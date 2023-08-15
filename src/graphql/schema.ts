import {
  GraphQLObjectType,
  GraphQLString,
  GraphQLInt,
  GraphQLSchema,
} from 'graphql'
import { db } from '../db'
import { ingredients } from '../db/schema/ingredients'
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
  },
})

export const schema = new GraphQLSchema({
  query: RootQuery,
})
