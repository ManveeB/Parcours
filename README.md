# Parcours — multi-user GitHub Pages build (1.3)

Parcours is a responsive French-learning app for the 112-day B1/B2 study path. This package includes the existing learning content, podcasts and shows library, and cat favicon, with Supabase email/password accounts and per-account cloud sync.

## Fixes in build 1.3

- Save failures now show an accessible warning immediately, including retry and backup-export actions. Draft status no longer says “autosaved” when the browser write failed.
- The study-day selector moves onto its own row on mobile with a usable width and larger controls.
- Sentence drills have a separate attempt per study day. “Try again without answers” archives previous attempts and reveals them in a history panel; answers are no longer carried from one day into another.
- The review screen offers a clear action if cards become due after a session finishes. That action opens only the due cards.
- Secondary text has stronger contrast, reading sizes and touch targets are larger, and the 112-day progress grid uses seven columns on small phones.
- Hosted installation copy and reset wording are clearer. The service-worker cache and displayed build version are now 1.3.

## Publish / configure

**Cloud accounts will work only after configuring your Supabase project.** Run `supabase-schema.sql`, set the authentication Site URL and allowed redirect to `https://manveeb.github.io/Parcours/`, and add the project URL plus public publishable/anon key to `supabase-config.js`.

Never put a service-role or secret key in this public repository. Row-level security in the supplied SQL is required.

## Files

- `index.html`: app UI and account/sync logic
- `supabase-config.js`: public project configuration template (blank by default)
- `supabase-schema.sql`: database table, RLS policies and timestamp trigger
- `SUPABASE_SETUP.md`: configuration and isolation-test instructions
- `assets/`: cat favicon and app icons
- `manifest.webmanifest`, `sw.js`, `.nojekyll`: PWA and static-host files

## Validation performed for build 1.3

- Both inline JavaScript bundles and `sw.js` pass Node syntax checks.
- Chromium component checks with a mocked Supabase client verified mobile day-selector sizing, independent day-specific drill attempts, archiving/retrying a drill, visible save-failure warning, and the due-card refresh flow.
- At 390 px, the day selector was 258 px wide and progress-grid buttons were about 39 × 39 px. Secondary text contrast was calculated at about 6.02:1 on white and 5.60:1 on the app background.

These are local component checks, not a live Supabase or physical-device test. After uploading, test sign-in, account isolation, cross-device sync and home-screen installation on your actual GitHub Pages deployment.
