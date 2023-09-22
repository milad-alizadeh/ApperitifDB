import type { Config } from 'drizzle-kit'
import dotenv from 'dotenv'

dotenv.config()

console.log(process.env.DB_URL, 'url')

export default {
  schema: './src/db/schema',
  out: './supabase/migrations',
  driver: 'pg',
  dbCredentials: {
    connectionString: process.env.DB_URL,
  },
} satisfies Config
