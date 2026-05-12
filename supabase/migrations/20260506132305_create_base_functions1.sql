-- ==========================================================
-- CREATE BASE FUNCTIONS
-- 
-- Deskripsi: Mendefinisikan fungsi utilitas dasar untuk audit fields, 
--            sanitasi input, dan auto-generate username.
-- ==========================================================

CREATE OR REPLACE FUNCTION public.set_audit_fields()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    NEW.updated_by = COALESCE(auth.uid(), NEW.updated_by);         

    IF TG_OP = 'INSERT' THEN
        NEW.created_at = NOW();
        NEW.created_by = COALESCE(auth.uid(), NEW.created_by);   
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SET search_path = public;


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
    counter := counter + 1;
    END LOOP;

    RETURN candidate;
END;
$$ LANGUAGE plpgsql SET search_path = public;
