import express from 'express'
import { graphqlHTTP } from 'express-graphql'
import { schema } from './graphql/schema'

const app = express()
const port = 3000

app.use(
  '/graphql',
  graphqlHTTP({
    schema,
    graphiql: true,
  }),
)

app.listen(port, () => {
  console.log(`Express listening at http://localhost:${port}`)
})
