-- -- Cara Termudah
-- drop schema public cascade;
-- create schema public;
-- truncate table supabase_migrations.schema_migrations;


drop table if exists public.shops cascade;
drop table if exists public.profiles cascade;

drop function if exists public.set_audit_fields cascade;
drop function if exists public.sanitize_username cascade;
drop function if exists public.sanitize_full_name cascade;
drop function if exists public.generate_username cascade;
drop function if exists public.handle_new_user cascade;
drop function if exists public.set_owner_id cascade;

drop trigger if exists set_profiles_audit on public.profiles;
drop trigger if exists set_shops_audit on public.shops;
drop trigger if exists on_auth_user_created on auth.users;
drop trigger if exists set_shops_owner on public.shops;

drop policy if exists "Anyone logged in can read active profiles" on public.profiles;
drop policy if exists "Users can view own profile" on public.profiles;
drop policy if exists "Users can update own profile" on public.profiles;
drop policy if exists "No direct insert" on public.profiles;
drop policy if exists "Users cannot delete profiles" on public.profiles;

drop policy if exists "User can create own shop only" on public.shops;
drop policy if exists "Owner can update shop" on public.shops;
drop policy if exists "Anyone can read active shops" on public.shops;

truncate table supabase_migrations.schema_migrations;
