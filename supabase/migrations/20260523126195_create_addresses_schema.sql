-- ==========================================================
-- ADDRESSES TABLE
-- 
-- Deskripsi: Membuat tabel addresses untuk data alamat  
--            buyers dan sellers,
-- ==========================================================

CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE public.addresses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    profile_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    
    title TEXT NOT NULL,          
    recipient_name TEXT NOT NULL, 
    phone_number TEXT NOT NULL,
    full_address TEXT NOT NULL,
    province_id INT,
    province_name TEXT,
    city_id INT,
    city_name TEXT,
    district_id INT,
    district_name TEXT,
    subdistrict_id INT,
    subdistrict_name TEXT,
    zip_code TEXT,
    api TEXT,

    location geography(Point, 4326),

    is_default_shipping BOOLEAN DEFAULT false, 
    is_shop_pickup BOOLEAN DEFAULT false,      
    
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID REFERENCES auth.users(id),
    updated_by UUID REFERENCES auth.users(id),
    deleted_at TIMESTAMPTZ,


    CONSTRAINT chk_title_length
    CHECK (char_length(trim(title)) > 0),

    CONSTRAINT chk_recipient_name_length
    CHECK (char_length(trim(recipient_name)) > 0),

    CONSTRAINT chk_phone_number_format
    CHECK (phone_number ~ '^(\+62|62|0)[0-9]{8,15}$'),

    CONSTRAINT chk_full_address_length
    CHECK (char_length(trim(full_address)) > 0),

    CONSTRAINT chk_zip_code_format
    CHECK (
        zip_code ~ '^[0-9]{5,15}$'
    ),
    
    CONSTRAINT chk_pickup_requires_location
    CHECK (
        NOT is_shop_pickup
        OR (
            location IS NOT NULL
            OR trim(full_address) <> ''
        )
    ),

    CONSTRAINT chk_pickup_not_default_shipping
    CHECK (
        NOT (
            is_shop_pickup = true
            AND is_default_shipping = true
        )
    )
);

CREATE INDEX idx_addresses_profile_id ON public.addresses(profile_id);
CREATE INDEX idx_addresses_active ON public.addresses(profile_id) WHERE deleted_at IS NULL;
CREATE INDEX idx_addresses_location ON public.addresses USING GIST(location);

CREATE UNIQUE INDEX uniq_default_shipping_per_profile
    ON public.addresses(profile_id)
    WHERE is_default_shipping = true
    AND deleted_at IS NULL;


CREATE OR REPLACE FUNCTION public.ensure_single_default_address()
RETURNS trigger AS $$
BEGIN
  IF NEW.is_default_shipping = true THEN
    UPDATE public.addresses
    SET is_default_shipping = false
    WHERE profile_id = NEW.profile_id
      AND id <> NEW.id
      AND deleted_at IS NULL;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_single_default_address
    BEFORE INSERT OR UPDATE
    ON public.addresses
    FOR EACH ROW
    EXECUTE FUNCTION public.ensure_single_default_address();

CREATE TRIGGER set_addresses_audit
    BEFORE INSERT OR UPDATE ON public.addresses
    FOR EACH ROW EXECUTE FUNCTION public.set_audit_fields();

CREATE OR REPLACE FUNCTION public.soft_delete_address(address_id UUID)
RETURNS void
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    UPDATE public.addresses
    SET deleted_at = NOW(),
        updated_at = NOW(),
        updated_by = auth.uid()
    WHERE id = address_id
      AND profile_id = auth.uid()
      AND is_shop_pickup = false
      AND deleted_at IS NULL
      AND is_default_shipping = false;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Failed deleting address';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- RLS & Policies
ALTER TABLE public.addresses ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own addresses"
ON public.addresses
FOR SELECT
USING (
    profile_id = auth.uid() AND 
    deleted_at IS NULL
);

CREATE POLICY "Users can insert own addresses"
ON public.addresses
FOR INSERT
WITH CHECK (
    profile_id = auth.uid()
    AND (
        is_shop_pickup = false
        OR (
            is_shop_pickup = true
            AND NOT EXISTS (
                SELECT 1 FROM public.addresses
                WHERE profile_id = auth.uid()
                  AND is_shop_pickup = true
                  AND deleted_at IS NULL
            )
        )
    )
);

CREATE POLICY "Users can update and soft delete own addresses"
ON public.addresses
FOR UPDATE
USING (
    profile_id = auth.uid()
    AND deleted_at IS NULL
)
WITH CHECK (
    profile_id = auth.uid()
    AND (
        (is_shop_pickup = false)
        OR (is_shop_pickup = true AND deleted_at IS NULL)
    )
);


-- VIEW
CREATE OR REPLACE VIEW public.shop_pickup_addresses AS
SELECT
    id,
    title,
    full_address,
    province_name,
    city_name,
    district_name,
    subdistrict_name,
    location,
    ST_Y(location::geometry) AS latitude,
    ST_X(location::geometry) AS longitude
FROM public.addresses
WHERE 
    is_shop_pickup = true
    AND deleted_at IS NULL;

GRANT SELECT
ON public.shop_pickup_addresses
TO anon, authenticated;