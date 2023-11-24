import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.38.5'
import { corsHeaders } from '../_shared/cors.ts'
import { Database } from '../_shared/types.ts'

Deno.serve(async (req) => {
  // Enable CORS for browser-side requests
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  // Setup Supabase client
  const supabase = createClient<Database>(
    Deno.env.get('SUPABASE_URL') as string,
    Deno.env.get('SUPABASE_ANON_KEY') as string,
  )

  const { filename, bucket } = await req.json()

  if (!filename || !bucket) {
    return new Response(
      JSON.stringify({ error: 'No filename or bucket provided' }),
      {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 400,
      },
    )
  }

  const { data, error } = await supabase.storage.from(bucket).list('', {
    limit: 100,
    search: filename.split('.').slice(0, -1).join('.'),
  })

  if (error) {
    return new Response(JSON.stringify({ error }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 500,
    })
  }

  if (data.length === 0) {
    return new Response(JSON.stringify({ error: 'No images found' }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 404,
    })
  }

  const filenames = data.map((item: { name: string }) => item.name)

  const { data: deleteData, error: deleteError } = await supabase.storage
    .from(bucket)
    .remove(filenames)

  if (deleteError) {
    return new Response(JSON.stringify({ error: deleteError }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 500,
    })
  }

  return new Response(JSON.stringify({ data: deleteData }), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    status: 200,
  })
})
