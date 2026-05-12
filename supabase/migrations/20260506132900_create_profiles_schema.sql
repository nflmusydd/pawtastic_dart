-- ==========================================================
-- CREATE PROFILES SCHEMA
-- 
-- Deskripsi: Membuat tabel profiles untuk menyimpan data user tambahan
--            beserta index, trigger audit, dan Row Level Security (RLS).
-- ==========================================================

CREATE TABLE public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,

    username TEXT NOT NULL UNIQUE,
    full_name TEXT NOT NULL DEFAULT '',
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
);

CREATE INDEX idx_profiles_active ON public.profiles(id) WHERE deleted_at IS NULL;


CREATE TRIGGER set_profiles_audit
BEFORE INSERT OR UPDATE ON public.profiles
FOR EACH ROW EXECUTE FUNCTION public.set_audit_fields();


-- RLS & Policies
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

CREATE POLICY "Users cannot delete profiles"
ON public.profiles
FOR DELETE
USING (false);
