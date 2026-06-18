--                                      ===============================================================================
--                                      ==================================== TABLE ====================================
--                                      ===============================================================================

-- =====================
-- PROFILES
-- =====================
CREATE TABLE public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,

    username TEXT NOT NULL,
    full_name TEXT NOT NULL DEFAULT '',
    -- phone_number TEXT,       --cukup di auth
    avatar_url TEXT,

    status TEXT NOT NULL DEFAULT 'active'
            CHECK (status IN ('active','inactive','banned')),
            
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID REFERENCES auth.users(id),
    updated_by UUID REFERENCES auth.users(id),
    deleted_at TIMESTAMPTZ,

    CHECK (username ~ '^[a-z0-9_]+$'),                  -- constraint profiles_username_check 
    CHECK (full_name ~ '^[a-zA-Z0-9 \''\.\-]+$')        -- constraint profiles_full_name_check

    -- CHECK (phone_number IS NULL OR phone_number ~ '^\+?[0-9]{8,15}$') -- di frontend: strip spasi dash, dan normalize ke +62 kalau Indonesia

    CONSTRAINT chk_username_length 
        CHECK (char_length(trim(username)) >= 3 AND char_length(username) <= 30),
    
    CONSTRAINT chk_full_name_length 
        CHECK (char_length(trim(full_name)) >= 3 AND char_length(full_name) <= 100),  
);

CREATE INDEX idx_profiles_active ON public.profiles(id) WHERE deleted_at IS NULL;
-- CREATE UNIQUE INDEX idx_profiles_phone_unique ON public.profiles(phone_number) WHERE phone_number IS NOT NULL;

-- unique index ignore soft delete row
CREATE UNIQUE INDEX IF NOT EXISTS uniq_username_active 
    ON public.profiles(username) 
    WHERE deleted_at IS NULL;

-- =====================
-- SHOPS
-- =====================
CREATE TABLE public.shops (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    owner_id UUID NOT NULL
        REFERENCES public.profiles(id) ON DELETE CASCADE,

    store_slug TEXT NOT NULL,
    shop_name TEXT NOT NULL,
    description TEXT,
    is_verified boolean default false,

    status TEXT NOT NULL DEFAULT 'active'
        CHECK (status IN ('active','inactive','banned')),

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID REFERENCES auth.users(id),
    updated_by UUID REFERENCES auth.users(id),
    deleted_at TIMESTAMPTZ,

    CHECK (store_slug = LOWER(store_slug)),
    CHECK (store_slug ~ '^[a-z0-9-]+$')

    CONSTRAINT chk_shop_name_length
        CHECK (char_length(trim(shop_name)) > 0 AND char_length(shop_name) <= 100),
        
    CONSTRAINT chk_store_slug_length
        CHECK (char_length(trim(store_slug)) > 0 AND char_length(store_slug) <= 50),
        
    CONSTRAINT chk_shop_description_length
        CHECK (description IS NULL OR char_length(description) <= 1000);
);

-- CREATE INDEX idx_shops_owner_id ON public.shops(owner_id);  --sudah terindex karena unique
CREATE INDEX idx_shops_active ON public.shops(owner_id) WHERE deleted_at IS NULL;
CREATE INDEX idx_shops_slug ON public.shops(store_slug);

-- unique index ignore soft delete row
CREATE UNIQUE INDEX IF NOT EXISTS uniq_store_slug_active 
    ON public.shops(store_slug) 
    WHERE deleted_at IS NULL;
-- 1 profile  hanya bisa punya 1 shop 
CREATE UNIQUE INDEX IF NOT EXISTS uniq_shop_owner_active 
    ON public.shops(owner_id) 
    WHERE deleted_at IS NULL;


-- =====================
-- ADDRESSES
-- =====================
CREATE TABLE public.addresses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    profile_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    
    title TEXT NOT NULL,            -- e.g., "Home", "Office", "Main Warehouse", kalau seller = nama toko
    recipient_name TEXT NOT NULL,   -- seller = seller/contact name
    phone_number TEXT NOT NULL,
    full_address TEXT NOT NULL,
    province_id INT,                -- ID from Shipping API 
    province_name TEXT,             -- ID from Shipping API 
    city_id INT,
    city_name TEXT,
    district_id INT,
    district_name TEXT,
    subdistrict_id INT,
    subdistrict_name TEXT,
    zip_code TEXT,
    api TEXT,

    location geography(Point, 4326),

    is_default_shipping BOOLEAN DEFAULT false,      -- Used by Buyers for checkout
    is_shop_pickup BOOLEAN DEFAULT false,           -- Used by Sellers for courier pickup
    
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


--                                      ===============================================================================
--                                      ================================= VIEW TABLE =================================
--                                      ===============================================================================

-- ============================
-- View Shop tanpa phone_number
-- ============================
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



--                                      ===============================================================================
--                                      ============================ TRIGGERS & FUNCTIONS ============================
--                                      ===============================================================================

-- ========================
-- Trigger Set audit fields
-- ========================
CREATE OR REPLACE FUNCTION public.set_audit_fields()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    NEW.updated_by = COALESCE(auth.uid(), NEW.updated_by);          -- tetap tidak diperbolehkan lempar dari frontend, 

    IF TG_OP = 'INSERT' THEN
        NEW.created_at = NOW();
        NEW.created_by = COALESCE(auth.uid(), NEW.created_by);      -- parameter kedua hanya dijalankan function public.handle_new_user
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SET search_path = public;

CREATE TRIGGER set_profiles_audit
    BEFORE INSERT OR UPDATE ON public.profiles
    FOR EACH ROW EXECUTE FUNCTION public.set_audit_fields();

CREATE TRIGGER set_shops_audit
    BEFORE INSERT OR UPDATE ON public.shops
    FOR EACH ROW EXECUTE FUNCTION public.set_audit_fields();

CREATE TRIGGER set_addresses_audit
    BEFORE INSERT OR UPDATE ON public.addresses
    FOR EACH ROW EXECUTE FUNCTION public.set_audit_fields();

-- ================================
-- Function Auto Generate Username
-- ================================
CREATE OR REPLACE FUNCTION public.sanitize_username(input TEXT)
RETURNS TEXT AS $$
BEGIN
    RETURN LOWER(
        REGEXP_REPLACE(input, '[^a-zA-Z0-9_]', '', 'g')
    );
END;
$$ LANGUAGE plpgsql SET search_path = public;

CREATE OR REPLACE FUNCTION public.sanitize_full_name(input TEXT)
RETURNS TEXT AS $$
BEGIN
    RETURN REGEXP_REPLACE(input, '[^a-zA-Z0-9 \''\.\-]', '', 'g');
END;
$$ LANGUAGE plpgsql SET search_path = public;

CREATE OR REPLACE FUNCTION public.generate_username(base_name TEXT)
RETURNS TEXT AS $$
DECLARE
    candidate TEXT;
    counter INT := 0;
BEGIN
    base_name := LOWER(REPLACE(base_name, ' ', '_'));
    --
    IF LENGTH(base_name) > 25 THEN
        base_name := 'pawuser_';
    END IF;

    LOOP
    IF counter = 0 THEN
        candidate := base_name;
    ELSE
        candidate := base_name || counter;
    END IF;

    EXIT WHEN NOT EXISTS (
        SELECT 1 FROM public.profiles WHERE username = candidate
    );
    -- -- Race Condition Prevention Code (delete EXIT WHEN NOT EXISTS code)
    -- INSERT INTO profiles (id, username)
    -- VALUES (NEW.id, candidate)
    -- ON CONFLICT (username) DO NOTHING;
    -- IF FOUND THEN
    --   RETURN candidate;
    -- END IF;

    counter := counter + 1;
    END LOOP;

    RETURN candidate;
END;
$$ LANGUAGE plpgsql SET search_path = public;


-- ===================================
-- Trigger Insert New User to profiles
-- ===================================
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (
        id,
        username,
        full_name,
        avatar_url,
        created_by,
        updated_by
    )
    VALUES (
        NEW.id,
        sanitize_username(COALESCE(NEW.raw_user_meta_data->>'username', generate_username(COALESCE(NEW.raw_user_meta_data->>'full_name', 'user')))),
        sanitize_full_name((COALESCE(NEW.raw_user_meta_data->>'full_name', ''))),
        NEW.raw_user_meta_data->>'avatar_url',
        NEW.id, 
        NEW.id
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();


-- ==========================
-- Trigger Set shops owner_id 
-- ==========================
CREATE OR REPLACE FUNCTION public.set_owner_id()
RETURNS TRIGGER AS $$
BEGIN
    -- Default tetap auth.uid, tapi buat kedepannya kalo shops bisa dibuat superadmin, owner_id biar gak keisi auth superadmin
    NEW.owner_id := COALESCE(NEW.owner_id, auth.uid());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SET search_path = public;

CREATE TRIGGER set_shops_owner
    BEFORE INSERT ON public.shops
    FOR EACH ROW
    EXECUTE FUNCTION public.set_owner_id();


-- ===============================
-- Trigger UPPERCASE & LOWERCASE 
-- ===============================
CREATE OR REPLACE FUNCTION public.uppercase_fields()
RETURNS TRIGGER AS $$
DECLARE
  col TEXT;
  rec_json JSONB;
BEGIN
  rec_json := to_jsonb(NEW);
  FOR i IN 0..TG_NARGS - 1 LOOP
    col := TG_ARGV[i];
    IF rec_json ? col THEN
      rec_json := rec_json || jsonb_build_object(col, UPPER(rec_json->>col));
    END IF;
  END LOOP;
  NEW := jsonb_populate_record(NEW, rec_json);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION public.lowercase_fields()
RETURNS TRIGGER AS $$
DECLARE
    col TEXT;
    rec_json JSONB;
BEGIN
    rec_json := to_jsonb(NEW);
    FOR i IN 0..TG_NARGS - 1 LOOP
        col := TG_ARGV[i];
        IF rec_json ? col THEN
            rec_json := rec_json || jsonb_build_object(col, LOWER(rec_json->>col));
        END IF;
    END LOOP;
    NEW := jsonb_populate_record(NEW, rec_json);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION public.normalize_case_fields()
RETURNS TRIGGER AS $$
DECLARE
    arg TEXT;
    col TEXT;
    rec_json JSONB;
BEGIN
    rec_json := to_jsonb(NEW);

    FOR i IN 0..TG_NARGS - 1 LOOP
        arg := TG_ARGV[i];

        IF arg LIKE 'upper:%' THEN
            col := substring(arg FROM 7);
            rec_json := rec_json || jsonb_build_object(
                col,
                UPPER(rec_json->>col)
            );

        ELSIF arg LIKE 'lower:%' THEN
            col := substring(arg FROM 7);
            rec_json := rec_json || jsonb_build_object(
                col,
                LOWER(rec_json->>col)
            );
        END IF;
    END LOOP;

    NEW := jsonb_populate_record(NEW, rec_json);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_normalize_profiles_case
    BEFORE INSERT OR UPDATE ON public.profiles
    FOR EACH ROW
    EXECUTE FUNCTION public.lowercase_fields('username');

CREATE TRIGGER trg_normalize_shops_case
    BEFORE INSERT OR UPDATE ON public.shops
    FOR EACH ROW
    EXECUTE FUNCTION public.lowercase_fields('store_slug');

CREATE TRIGGER trg_normalize_addresses_case
    BEFORE INSERT OR UPDATE ON public.addresses
    FOR EACH ROW
    EXECUTE FUNCTION public.uppercase_fields('recipient_name', 'zip_code');


-- ===============================
-- Trigger trim text fields 
-- ===============================
CREATE OR REPLACE FUNCTION public.trim_text_fields()
RETURNS TRIGGER AS $$
DECLARE
    column_name TEXT;
    rec_json JSONB;
BEGIN
    rec_json := to_jsonb(NEW);
    FOR column_name IN
        SELECT col.column_name
        FROM information_schema.columns col
        WHERE col.table_schema = TG_TABLE_SCHEMA
            AND col.table_name = TG_TABLE_NAME
            AND col.data_type = 'text'
        LOOP
            IF rec_json ? column_name AND rec_json->>column_name IS NOT NULL THEN
                rec_json := rec_json || jsonb_build_object(column_name, trim(rec_json->>column_name));
            END IF;
        END LOOP;
    NEW := jsonb_populate_record(NEW, rec_json);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_trim_addresses
    BEFORE INSERT OR UPDATE ON public.addresses
    FOR EACH ROW EXECUTE FUNCTION public.trim_text_fields();

CREATE TRIGGER trg_trim_shops
    BEFORE INSERT OR UPDATE ON public.shops
    FOR EACH ROW EXECUTE FUNCTION public.trim_text_fields();

CREATE TRIGGER trg_trim_profiles
    BEFORE INSERT OR UPDATE ON public.profiles
    FOR EACH ROW EXECUTE FUNCTION public.trim_text_fields();


-- =========================================
-- Trigger to ensure single default address 
-- =========================================
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

-- =========================================
-- Function to soft delete address 
-- =========================================
CREATE OR REPLACE FUNCTION public.soft_delete_address(address_id UUID)
RETURNS void
SECURITY DEFINER            -- sementara pakai ini karena bug aneh
SET search_path = public
AS $$
BEGIN
    UPDATE public.addresses
    SET deleted_at = NOW(),
        updated_at = NOW(),
        updated_by = auth.uid()
    WHERE id = address_id
      AND profile_id = auth.uid();
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Address not found or not owned by user';
    END IF;
END;
$$ LANGUAGE plpgsql;


--                                      ===============================================================================
--                                      ================================== POLICIES ==================================
--                                      ===============================================================================

-- =====================
-- PROFILES
-- =====================
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone logged in can read active profiles"
ON public.profiles
FOR SELECT
USING (status = 'active' AND deleted_at IS NULL );

CREATE POLICY "Users can view own profile"
ON public.profiles
FOR SELECT
USING (id = auth.uid() AND deleted_at IS NULL);

CREATE POLICY "Users can update own profile"
ON public.profiles
FOR UPDATE
USING (id = auth.uid())
WITH CHECK (id = auth.uid() AND status = 'active');

CREATE POLICY "No direct insert"
ON public.profiles
FOR INSERT
WITH CHECK (false);

-- belum tentu kepake
CREATE POLICY "Users cannot delete profiles"
ON public.profiles
FOR DELETE
USING (false);


-- =====================
-- SHOPS
-- =====================
ALTER TABLE public.shops ENABLE ROW LEVEL SECURITY;

CREATE POLICY "User can create own shop only"
ON public.shops
FOR INSERT
WITH CHECK (owner_id = auth.uid());

CREATE POLICY "Owner can update shop"
ON public.shops
FOR UPDATE
USING (owner_id = auth.uid()) 
WITH CHECK (owner_id = auth.uid());

CREATE POLICY "Anyone can read active shops"
ON public.shops
FOR SELECT
USING (deleted_at IS NULL AND status = 'active');


-- =====================
-- ADDRESSES
-- =====================
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
        deleted_at IS NULL
        OR is_shop_pickup = false
    )
);



--                                      ===============================================================================
--                                      ==================================== CRON ====================================
--                                      ===============================================================================

-- ======================================
-- CREATE CLEANUP UNCONFIRMED USERS CRON
-- =====================================
CREATE EXTENSION IF NOT EXISTS pg_cron;
GRANT USAGE ON SCHEMA cron TO postgres;
SELECT cron.schedule(
    'cleanup-unconfirmed-users', -- task name
    '0 1 * * *',                 -- Cron expression (01:00 AM)
    $$
    DELETE FROM auth.users 
    WHERE email_confirmed_at IS NULL 
      AND created_at < NOW() - INTERVAL '24 hours';
    $$
);
