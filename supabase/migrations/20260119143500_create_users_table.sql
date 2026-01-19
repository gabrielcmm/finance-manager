-- Create Users table for Telegram Bot
create table public.users (
  id uuid default gen_random_uuid() primary key,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  email text not null unique,
  username text,
  first_name text,
  is_allowed boolean default false
);

-- Enable RLS
alter table public.users enable row level security;

-- Policies
create policy "Enable read access for all users" on public.users for select using (true);
create policy "Enable insert for all users" on public.users for insert with check (true);
create policy "Enable update for all users" on public.users for update using (true);

-- Update FK references to point to public.users instead of auth.users

-- Accounts
alter table public.accounts
  drop constraint if exists accounts_user_id_fkey,
  add constraint accounts_user_id_fkey
  foreign key (user_id)
  references public.users(id)
  on delete cascade;

-- Categories
alter table public.categories
  drop constraint if exists categories_user_id_fkey,
  add constraint categories_user_id_fkey
  foreign key (user_id)
  references public.users(id)
  on delete cascade;

-- Transactions
alter table public.transactions
  drop constraint if exists transactions_user_id_fkey,
  add constraint transactions_user_id_fkey
  foreign key (user_id)
  references public.users(id)
  on delete cascade;
