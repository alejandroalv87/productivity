-- Run this once in your Supabase project's SQL Editor (Supabase dashboard -> SQL Editor -> New query).

create table if not exists household_data (
  household_code text not null,
  key text not null,
  value jsonb not null,
  updated_at timestamptz default now(),
  primary key (household_code, key)
);

-- Row Level Security: keep this ON.
alter table household_data enable row level security;

-- Simple policy so the app (using the public anon key) can read/write.
-- Protection here comes from keeping your household code private, the
-- same way an unlisted document link works — not from per-user login.
-- See README.md for how to upgrade to real authentication later.
create policy "household app access"
  on household_data
  for all
  using (true)
  with check (true);
