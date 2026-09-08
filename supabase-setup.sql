-- Create the reports table used by the quiz app.
create extension if not exists pgcrypto;

create table if not exists public.reports (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  rows jsonb not null default '{}'::jsonb,
  text text not null default ''
);

alter table public.reports enable row level security;

drop policy if exists "Allow anonymous insert" on public.reports;
create policy "Allow anonymous insert"
  on public.reports
  for insert
  with check (true);

drop policy if exists "Allow anonymous select" on public.reports;
create policy "Allow anonymous select"
  on public.reports
  for select
  using (true);

drop policy if exists "Allow anonymous delete" on public.reports;
create policy "Allow anonymous delete"
  on public.reports
  for delete
  using (true);

create index if not exists reports_created_at_idx
  on public.reports (created_at desc);
