-- Parcours per-user cloud state for Supabase.
-- Run this in the Supabase SQL Editor before enabling accounts.
-- All private progress is stored in one JSONB row per authenticated user.

create table if not exists public.parcours_user_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  state jsonb not null check (jsonb_typeof(state) = 'object'),
  updated_at timestamptz not null default now()
);

alter table public.parcours_user_state enable row level security;
alter table public.parcours_user_state force row level security;

revoke all on table public.parcours_user_state from public, anon, authenticated;
grant select, insert, update on table public.parcours_user_state to authenticated;

-- Re-runnable policies: authenticated users may only access their own row.
drop policy if exists "Parcours users read own state" on public.parcours_user_state;
drop policy if exists "Parcours users insert own state" on public.parcours_user_state;
drop policy if exists "Parcours users update own state" on public.parcours_user_state;

create policy "Parcours users read own state"
  on public.parcours_user_state for select to authenticated
  using ((select auth.uid()) = user_id);

create policy "Parcours users insert own state"
  on public.parcours_user_state for insert to authenticated
  with check ((select auth.uid()) = user_id);

create policy "Parcours users update own state"
  on public.parcours_user_state for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

create or replace function public.parcours_set_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at = pg_catalog.now();
  return new;
end;
$$;

drop trigger if exists parcours_user_state_updated_at on public.parcours_user_state;
create trigger parcours_user_state_updated_at
  before update on public.parcours_user_state
  for each row execute function public.parcours_set_updated_at();

-- Do not add policies for anon. Do not expose or use the service-role key in the app.
