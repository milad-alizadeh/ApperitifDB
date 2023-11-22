import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import { corsHeaders } from '../_shared/cors.ts'
import {
  ImageMagick,
  IMagickImage,
  initialize,
  MagickFormat,
} from 'https://deno.land/x/imagemagick_deno/mod.ts'

console.log(`Function "browser-with-cors" up and running!`)

Deno.serve(async (req: any) => {
  // Enable CORS for browser-side requests
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  // Setup Supabase client
  const supabaseClient = createClient(
    Deno.env.get('SUPABASE_URL') as string,
    Deno.env.get('SUPABASE_ANON_KEY') as string,
  )

  // Get image from request
  const mainImage = new Uint8Array(await req.arrayBuffer())

  // Initialize ImageMagick
  await initialize()

  const imageSizes = [
    {
      width: 160,
      height: 160,
      name: 'thumb',
    },
    {
      width: 320,
      height: 320,
      name: 'thumb@2x',
    },
    {
      width: 480,
      height: 480,
      name: 'thumb@3x',
    },
    {
      width: 400,
      height: 400,
      name: 'medium',
    },
    {
      width: 800,
      height: 800,
      name: 'medium@2x',
    },
  ]

  // Generate random file name
  const fileName = Math.random().toString(36).substring(2, 15)

  imageSizes.forEach(async ({ width, height, name }) => {
    await ImageMagick.read(mainImage, async (img: IMagickImage) => {
      img.resize(width, height)

      await img.write(MagickFormat.Jpeg, (resized: Uint8Array) => {
        // Upload resiaed images to Supabase Storage
        supabaseClient.storage
          .from('public-images')
          .upload(`${fileName}-${name}.jpg`, resized, {
            contentType: 'image/jpeg',
            upsert: true,
          })
      })
    })
  })

  // Upload image to Supabase Storage
  const { data, error } = await supabaseClient.storage
    .from('public-images')
    .upload(`${fileName}.jpg`, mainImage, {
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
