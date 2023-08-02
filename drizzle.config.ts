import type { Config } from 'drizzle-kit'

export default {
  schema: './src/db/schema',
  out: './supabasse/migrations',
  driver: 'pg',
} satisfies Config
