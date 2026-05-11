--                                      ===============================================================================
--                                      ==================================== TABLE ====================================
--                                      ===============================================================================

-- =====================
-- PROFILES
-- =====================
CREATE TABLE public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,

    username TEXT NOT NULL UNIQUE,
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

    CHECK (username ~ '^[a-z0-9_]+$'),
    CHECK (full_name ~ '^[a-zA-Z0-9 \''\.\-]+$')
    -- CHECK (phone_number IS NULL OR phone_number ~ '^\+?[0-9]{8,15}$') -- di frontend: strip spasi dash, dan normalize ke +62 kalau Indonesia
);

CREATE INDEX idx_profiles_active ON public.profiles(id) WHERE deleted_at IS NULL;
-- CREATE UNIQUE INDEX idx_profiles_phone_unique ON public.profiles(phone_number) WHERE phone_number IS NOT NULL;

-- =====================
-- SHOPS
-- =====================
CREATE TABLE public.shops (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    owner_id UUID NOT NULL UNIQUE
        REFERENCES public.profiles(id) ON DELETE CASCADE,

    store_slug TEXT NOT NULL UNIQUE,
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
);

-- CREATE INDEX idx_shops_owner_id ON public.shops(owner_id);  --sudah terindex karena unique
CREATE INDEX idx_shops_active ON public.shops(owner_id) WHERE deleted_at IS NULL;
CREATE INDEX idx_shops_slug ON public.shops(store_slug);



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