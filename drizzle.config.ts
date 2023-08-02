import type { Config } from 'drizzle-kit'

export default {
  schema: './src/db/schema',
  out: './supabase/migrations',
  driver: 'pg',
} satisfies Config
