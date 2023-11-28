import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import { corsHeaders } from '../_shared/cors.ts'
import { imageSizes } from '../_shared/image-sizes.ts'
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
  const authHeader = req.headers.get('Authorization')!

  console.log('Authorization:', authHeader)

  // Setup Supabase client
  const supabaseClient = createClient(
    Deno.env.get('SUPABASE_URL') as string,
    Deno.env.get('SUPABASE_ANON_KEY') as string,
    { global: { headers: { Authorization: authHeader } } },
  )

  // Get image from request
  const mainImage = new Uint8Array(await req.arrayBuffer())

  // Initialize ImageMagick
  try {
    await initialize()
  } catch (initError) {
    console.error('Error initializing ImageMagick:', initError)
    return new Response(JSON.stringify({ error: initError.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 500,
    })
  }

  // Generate random file name
  const fileName = Math.random().toString(36).substring(2, 15)

  try {
    for (const { width, height, name } of imageSizes) {
      await ImageMagick.read(mainImage, async (img: IMagickImage) => {
        try {
          img.resize(width, height)

          console.log(`Processing ${fileName}${name ? `-${name}` : ''}.jpg`)

          await img.write(MagickFormat.Jpeg, async (resized: Uint8Array) => {
            try {
              // Upload resized images to Supabase Storage
              const { error: uploadError } = await supabaseClient.storage
                .from('public-images')
                .upload(`${fileName}${name ? `-${name}` : ''}.jpg`, resized, {
                  contentType: 'image/jpeg',
                  upsert: true,
                })

              if (uploadError) {
                throw uploadError
              }
            } catch (uploadError) {
              console.error('Error during upload:', uploadError)
              throw uploadError
            }
          })
        } catch (imgError) {
          console.error('Error processing image:', imgError)
          throw imgError
        }
      })
    }

    return new Response(JSON.stringify({ path: `${fileName}.jpg` }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  } catch (e) {
    console.error('General error:', e)
    return new Response(JSON.stringify({ error: e.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 500,
    })
  }
})
