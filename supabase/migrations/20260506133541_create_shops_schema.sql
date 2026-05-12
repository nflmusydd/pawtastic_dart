-- ==========================================================
-- CREATE SHOPS SCHEMA

-- Deskripsi: Membuat tabel shops untuk data toko penjual (seller), 
--            termasuk slug, trigger audit, dan kebijakan RLS.
-- ==========================================================

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

CREATE INDEX idx_shops_active ON public.shops(owner_id) WHERE deleted_at IS NULL;
CREATE INDEX idx_shops_slug ON public.shops(store_slug);


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

CREATE TRIGGER set_shops_audit
BEFORE INSERT OR UPDATE ON public.shops
FOR EACH ROW EXECUTE FUNCTION public.set_audit_fields();


-- RLS & Policies
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
