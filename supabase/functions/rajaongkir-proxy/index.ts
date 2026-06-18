import { serve } from "https://deno.land/std@0.168.0/http/server.ts"

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

const KOMERCE_BASE_URL = 'https://rajaongkir.komerce.id/api/v1/destination';

serve(async (req) => {
  // Handle CORS
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const apiKey = Deno.env.get('RAJAONGKIR_SHIPPING_API_KEY')
    if (!apiKey) {
      throw new Error("RAJAONGKIR_SHIPPING_API_KEY not found")
    }

    const body = await req.json()
    const action = body.action

    let url = '';
    
    if (action === 'get_provinces') {
      url = `${KOMERCE_BASE_URL}/province`;
    } else if (action === 'get_cities') {
      const provinceId = body.province_id;
      if (!provinceId) throw new Error("Please fill province first");
      url = `${KOMERCE_BASE_URL}/city/${provinceId}`;
    } else if (action === 'get_districts') {
      const cityId = body.city_id;
      if (!cityId) throw new Error("Please fill city first");
      url = `${KOMERCE_BASE_URL}/district/${cityId}`;
    } else if (action === 'get_subdistricts') {
      const districtId = body.district_id;
      if (!districtId) throw new Error("Please fill district first");
      url = `${KOMERCE_BASE_URL}/sub-district/${districtId}`;
    } else {
      throw new Error("Action not valid");
    }

    const response = await fetch(url, {
      method: 'GET',
      headers: {
        'Accept': 'application/json',
        'key': apiKey,
      },
    })

    const data = await response.json()

    if (!response.ok) {
      throw new Error(data.message || "Failed to connect to Komerce Server")
    }

    // Map Komerce response to match the structure expected by the app
    // Komerce fields: id, name, type
    // RajaOngkir fields: province_id, province, city_id, city_name, subdistrict_id, subdistrict_name
    const mappedResults = data.data.map((item: any) => ({
      ...item,
      province_id: item.id?.toString(),
      province: item.name,
      city_id: item.id?.toString(),
      city_name: item.name,
      district_id: item.id?.toString(),
      district_name: item.name,
      subdistrict_id: item.id?.toString(),
      subdistrict_name: item.name,
      api: 'komerce'
    }));

    const mappedData = {
      rajaongkir: {
        results: mappedResults
      }
    };

    return new Response(
      JSON.stringify(mappedData),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
    )
  } catch (error: any) {
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
    )
  }
})
