-- ==========================================================
-- CREATE AUTH USER CREATED TRIGGERS
-- 
-- Deskripsi: Membuat fungsi handler dan trigger untuk otomatis membuat 
--            entry di tabel profiles saat user baru mendaftar (sign up).
-- ==========================================================

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
