-- ==========================================================
-- ALTER PROFILES AND SHOPS SCHEMA
-- 
-- Deskripsi: Menambahkan pengecekan ketat (integrity checks) 
--            pada tabel profiles dan shops agar data 
--            lebih konsisten, dan ubah function sanitize_username
-- ==========================================================

ALTER TABLE public.profiles
    DROP CONSTRAINT IF EXISTS profiles_username_key,
    
    ADD CONSTRAINT chk_username_length 
        CHECK (char_length(trim(username)) >= 3 AND char_length(username) <= 30),
    
    ADD CONSTRAINT chk_full_name_length 
        CHECK (char_length(trim(full_name)) >= 3 AND char_length(full_name) <= 100); 

-- Unique Index ignoring soft deleted rows
CREATE UNIQUE INDEX IF NOT EXISTS uniq_username_active 
    ON public.profiles(username) 
    WHERE deleted_at IS NULL;


ALTER TABLE public.shops
    DROP CONSTRAINT IF EXISTS shops_store_slug_key,
    DROP CONSTRAINT IF EXISTS shops_owner_id_key,

    ADD CONSTRAINT chk_shop_name_length
        CHECK (char_length(trim(shop_name)) > 0 AND char_length(shop_name) <= 100),
        
    ADD CONSTRAINT chk_store_slug_length
        CHECK (char_length(trim(store_slug)) > 0 AND char_length(store_slug) <= 50),
        
    ADD CONSTRAINT chk_shop_description_length
        CHECK (description IS NULL OR char_length(description) <= 1000);

CREATE UNIQUE INDEX IF NOT EXISTS uniq_store_slug_active 
    ON public.shops(store_slug) 
    WHERE deleted_at IS NULL;

CREATE UNIQUE INDEX IF NOT EXISTS uniq_shop_owner_active 
    ON public.shops(owner_id) 
    WHERE deleted_at IS NULL;


-- function
CREATE OR REPLACE FUNCTION public.generate_username(base_name TEXT)
RETURNS TEXT AS $$
DECLARE
    candidate TEXT;
    counter INT := 0;
BEGIN
    base_name := LOWER(REPLACE(base_name, ' ', '_'));
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
    counter := counter + 1;
    END LOOP;

    RETURN candidate;
END;
$$ LANGUAGE plpgsql SET search_path = public;

-- Trigger
CREATE TRIGGER trg_normalize_addresses_case
    BEFORE INSERT OR UPDATE ON public.addresses
    FOR EACH ROW
    EXECUTE FUNCTION public.normalize_case_fields(
        'upper:recipient_name',
        'upper:province_name',
        'upper:city_name',
        'upper:district_name',
        'upper:subdistrict_name'
    );

CREATE TRIGGER trg_normalize_profiles_case
    BEFORE INSERT OR UPDATE ON public.profiles
    FOR EACH ROW
    EXECUTE FUNCTION public.normalize_case_fields(
        'lower:username'
    );

CREATE TRIGGER trg_normalize_shops_case
    BEFORE INSERT OR UPDATE ON public.shops
    FOR EACH ROW
    EXECUTE FUNCTION public.normalize_case_fields(
        'lower:store_slug'
    );


CREATE TRIGGER trg_trim_addresses
    BEFORE INSERT OR UPDATE ON public.addresses
    FOR EACH ROW EXECUTE FUNCTION public.trim_text_fields();

CREATE TRIGGER trg_trim_shops
    BEFORE INSERT OR UPDATE ON public.shops
    FOR EACH ROW EXECUTE FUNCTION public.trim_text_fields();

CREATE TRIGGER trg_trim_profiles
    BEFORE INSERT OR UPDATE ON public.profiles
    FOR EACH ROW EXECUTE FUNCTION public.trim_text_fields();