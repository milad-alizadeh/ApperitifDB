import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import { corsHeaders } from '../_shared/cors.ts'
import {
  ImageMagick,
  IMagickImage,
  initialize,
  MagickFormat,
} from 'https://deno.land/x/imagemagick_deno/mod.ts'

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
      name: 'thumbnail',
    },
    {
      width: 320,
      height: 320,
      name: 'thumbnail@2x',
    },
    {
      width: 480,
      height: 480,
      name: 'thumbnail@3x',
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
    {
      width: 800,
      height: 800,
      name: 'medium@2x',
    },
    {
      width: 1024,
      height: 1024,
      name: '',
    },
  ]

  // Generate random file name
  const fileName = Math.random().toString(36).substring(2, 15)

  try {
    for (const { width, height, name } of imageSizes) {
      await ImageMagick.read(mainImage, async (img: IMagickImage) => {
        img.resize(width, height)

        await img.write(MagickFormat.Jpeg, async (resized: Uint8Array) => {
          // Upload resized images to Supabase Storage
          const { error: uploadError } = await supabaseClient.storage
            .from('public-images')
            .upload(`${fileName}${name ? `-${name}` : ''}.jpg`, resized, {
              contentType: 'image/jpeg',
              upsert: false,
            })

          if (uploadError) {
            throw uploadError
          }
        })
      })
    }

    return new Response(JSON.stringify({ path: `${fileName}.jpg` }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  } catch (e) {
    return new Response(JSON.stringify(e.message), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 500,
    })
  }
})
