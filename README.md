https://21st.dev/ to get design ideas 
# Us — shared life & work app

A private, shared web app for you and your partner: calendar/to-dos, notes,
goals, a watchlist, a supermarket list, big-purchase tracking, and an AI
advisor that can answer questions using your real data.

This version is a **standalone website** — host it on your own domain,
outside of Claude.ai. That means two things need to be connected before it
works:

1. A **Supabase** database (free) — stores your shared data.
2. A **serverless function** (included, runs on Vercel) — holds your
   Anthropic API key so the AI advisor works without exposing the key in
   the browser.

Total setup time: ~15 minutes. No coding required, just following steps.

---

## 1. Create a free Supabase project

1. Go to https://supabase.com and sign up (free tier is enough).
2. Create a new project. Pick any name/password/region.
3. Once it's created, go to the **SQL Editor** (left sidebar) → **New query**.
4. Open `supabase/schema.sql` from this project, paste its contents in, and
   click **Run**. This creates the `household_data` table.
5. Go to **Project Settings → API**. Copy:
   - **Project URL** (looks like `https://xxxxx.supabase.co`)
   - **anon public** key (a long string) Settings → API Keys Look for Publishable key

## 2. Add your keys to the app

Open `index.html`, find this block near the top of the `<script>` tag:

```js
const CONFIG = {
  SUPABASE_URL: 'YOUR_SUPABASE_URL',
  SUPABASE_ANON_KEY: 'YOUR_SUPABASE_ANON_KEY',
  ADVISOR_ENDPOINT: '/api/advisor'
};
```

Replace `YOUR_SUPABASE_URL` and `YOUR_SUPABASE_ANON_KEY` with the values you
copied. Leave `ADVISOR_ENDPOINT` as is.

> The anon key is safe to have in front-end code — it only allows what the
> database policy (from `schema.sql`) permits.

## 3. Get an Anthropic API key

1. Go to https://console.anthropic.com and create an API key.
2. Keep it somewhere safe for the next step — you'll paste it into Vercel,
   never into the app's front-end code.

## 4. Deploy to Vercel (free)

1. Push this folder to a GitHub repository (or use Vercel's CLI/drag-and-drop
   deploy if you'd rather skip GitHub — see https://vercel.com/docs for the
   latest options).
2. Go to https://vercel.com, sign up, and **import** the repository (or
   folder).
3. Before deploying, add an environment variable:
   - Name: `ANTHROPIC_API_KEY`
   - Value: the key from step 3
4. Deploy. Vercel will give you a live URL like `us-app.vercel.app`.
5. (Optional) In Vercel's project settings you can attach your own custom
   domain instead of the vercel.app one.

## 5. Use it

Open your new URL. You and your partner should each:
1. Visit the site.
2. Enter the **same household code** (anything you both agree on, e.g.
   `sunset-otter-42`) — this is what keeps your two accounts linked to the
   same shared data. It's saved in your browser so you won't need to
   re-enter it each visit.

That's it — you're both looking at the same shared tasks, notes, goals,
watchlist, shopping list, and big buys, and the AI advisor works.

---

## A note on security

The household code is like an unlisted link, not a password-protected
login — anyone who has the code (or who guesses it) can see and edit the
data. That's a reasonable tradeoff for a couple's shared planner, but:

- Don't reuse a real password as your household code.
- Don't post the code anywhere public.
- If you'd like real per-person login (email/password or Google sign-in)
  instead, Supabase supports this natively (Supabase Auth) — let me know
  and I can wire that in as an upgrade.

## Updating the app later

Any time you want new features or design changes, edit `index.html` (and
`api/advisor.js` if the AI advisor logic changes) and redeploy — Vercel
redeploys automatically on every push if connected to GitHub.
