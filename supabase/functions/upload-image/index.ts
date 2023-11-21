import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import { corsHeaders } from '../_shared/cors.ts'

console.log(`Function "browser-with-cors" up and running!`)

Deno.serve(async (req: any) => {
  // This is needed if you're planning to invoke your function from a browser.
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  const supabaseClient = createClient(
    Deno.env.get('SUPABASE_URL') as string,
    Deno.env.get('SUPABASE_ANON_KEY') as string,
  )

  const image = new Uint8Array(await req.arrayBuffer())
  const fileName = Math.random().toString(36).substring(2, 15)

  const { data, error } = await supabaseClient.storage
    .from('public-images')
    .upload(`${fileName}.jpg`, image, {
      contentType: 'image/jpeg',
      upsert: true,
    })

  if (error) {
    return new Response(JSON.stringify(error.message), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: error.statusCode,
    })
  } else {
    return new Response(JSON.stringify(data), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  }
})
