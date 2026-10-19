# Parcours — Supabase account and cloud-sync setup (app build 1.3)

This build keeps the existing static app and cat favicon on GitHub Pages. Supabase provides email/password authentication and private cloud storage. The app uses only the public publishable/anon key; PostgreSQL row-level security (RLS) restricts every record to its owner.

## Important status

The account UI and sync code are included, but **accounts will not work until you create/configure your own Supabase project**. The provided project URL and publishable key are already filled into `supabase-config.js`. This package cannot create a hosted Supabase project or run its SQL setup on your behalf. The 1.3 update also improves mobile controls, save-error visibility, fresh sentence-drill attempts, review-queue refresh, and text contrast. Do not use a service-role or secret key in `supabase-config.js`.

## 1. Create the Supabase project

1. Open your existing project at https://supabase.com/dashboard.
2. In **SQL Editor**, open `supabase-schema.sql` from this package and run the entire script.
3. The Project URL and publishable key are already set in `supabase-config.js`. Do not replace them with a `service_role` key or any secret key. If these credentials change, update the file using the new Project URL and publishable key.

   The file is served publicly by GitHub Pages. That is expected for a publishable key; **RLS is the security boundary**. The SQL script enables RLS, revokes anonymous access, and grants authenticated users access only to rows whose `user_id` equals `auth.uid()`.

## 2. Configure email authentication and redirects

In Supabase **Authentication → URL Configuration**:

- Set **Site URL** to `https://manveeb.github.io/Parcours/`.
- Add `https://manveeb.github.io/Parcours/` to the allowed redirect URLs. If you use preview URLs or a local test server, add only the exact additional URLs you need.
- Keep email/password authentication enabled. Email confirmation is recommended.

For reliable sign-up emails beyond initial testing, configure a trusted SMTP provider in Supabase. The built-in email service may have strict sending limits. Never disable RLS to get the app working.

## 3. Publish the update to GitHub Pages

1. Extract `Parcours_Multi_User_Supabase.zip`.
2. Upload the **contents** of the extracted folder to the root of your existing `Parcours` repository, replacing the older `index.html`, `sw.js`, and `README.md` and adding `supabase-config.js`, `supabase-schema.sql`, and this guide. Keep `assets/` at the repository root.
3. Commit the changes to `main`. GitHub Pages will redeploy the site.
4. Visit `https://manveeb.github.io/Parcours/`. If an old service-worker copy remains, close the app and reload; if needed, remove the installed PWA and clear that site's cached data before reopening.

## 4. Test account isolation before inviting anyone

1. Create Account A using an email address you control and confirm it if prompted.
2. Complete a task, add a personal phrase, save a draft, add tutor feedback, and save a media log.
3. Open Supabase **Table Editor → parcours_user_state**. A row should exist for Account A. Its `user_id` should match that account; its `state` JSON contains the user’s progress categories.
4. Sign out and create Account B with a different email. It should start with a separate learning state. Do not import Account A’s local progress into B.
5. Sign back into A on a second device/browser. The state should load from the cloud. Make one change, wait for **Synced to your account**, then check that it appears on the first device after refresh/reopen.
6. In Supabase, use the authenticated user context or app tests to verify Account B cannot select or update Account A's row. RLS is required even though the UI has separate accounts.

## Data architecture

- **Frontend:** static HTML/CSS/JavaScript on GitHub Pages. No private backend secret is embedded.
- **Identity:** Supabase Auth email/password; session persisted by the Supabase client.
- **Cloud state:** `public.parcours_user_state`, one row per user, with a JSONB `state` object. Its existing fields separately represent study progress, vocabulary/reviews, notebook/drafts/errors, settings/level observations, tutor notes, and media favourites/logs.
- **Access control:** RLS is enabled and forced. SELECT/INSERT/UPDATE policies require `auth.uid() = user_id`; anonymous users have no table grants. Deleting a Supabase Auth account cascades to its row.
- **Local cache:** `localStorage` is namespaced by the authenticated user ID. An old local-only workspace is imported only after an explicit confirmation. Local cache is not a substitute for cloud backup.
- **Sync safety:** saves are debounced. Updates use the last `updated_at` value as an optimistic concurrency check. If another device has changed the cloud row, the app asks whether to use the cloud copy or upload this device's copy rather than silently overwriting it. Use one active editing device at a time where possible.

## Privacy and limitations

- The table stores the current app state as one JSONB record per user, not a separate database table for every category. The JSON fields remain separate inside the state. This keeps the existing app schema compatible and makes the RLS boundary straightforward.
- The static course content is public because it is bundled in the website. User notes and progress are not stored in the public GitHub repository.
- The publishable key is not a secret. Never commit a Supabase service-role/secret key, personal backup JSON, or private tutor export.
- This build provides student accounts, not teacher accounts or sharing between students and teachers. Tutor feedback is private to the student account unless the student exports and shares it.
- Cloud sync needs an internet connection. When unavailable, the app keeps a user-specific local cache and marks it as not synced. Export backups regularly.
- Password reset and confirmation links must redirect to the exact GitHub Pages URL listed above. Email delivery depends on Supabase SMTP configuration.
- After setup, test on desktop and phone. I have packaged the integration, but cannot verify the live Supabase project or live deployment until your project credentials and SQL setup exist.
