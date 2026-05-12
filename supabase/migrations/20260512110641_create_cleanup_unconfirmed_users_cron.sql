-- ================================================================
-- CREATE CLEANUP UNCONFIRMED USERS CRON
-- 
-- Deskripsi: 
-- Hapus uncofirmed user dalam 24 hours pada 01:00 AM server time
-- ================================================================

CREATE EXTENSION IF NOT EXISTS pg_cron;

GRANT USAGE ON SCHEMA cron TO postgres;

SELECT cron.schedule(
    'cleanup-unconfirmed-users', 
    '0 1 * * *',                 
    $$
    DELETE FROM auth.users 
    WHERE email_confirmed_at IS NULL 
      AND created_at < NOW() - INTERVAL '24 hours';
    $$
);
