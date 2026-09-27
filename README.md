# Parcours — GitHub Pages package

This is the existing Parcours app, packaged for GitHub Pages. It is not yet deployed.
The cat favicon, 112-day programme and Podcasts & shows section are retained.
No build command, server, API key or package installation is needed for this version.

## Publish using the GitHub website

1. Sign in to GitHub and create a repository named `parcours`. Set it to Public
   to use GitHub Pages on GitHub Free. Turn on Add README to create the main branch.
2. Extract this ZIP. Inside your repository, choose Add file > Upload files.
   Upload the CONTENTS of the extracted folder, including the assets folder.
   Do not upload the ZIP or nest everything inside an extra Parcours folder.
   `index.html` must appear at the top level of your repository.
3. Commit the uploaded files to main. If you choose a new branch instead,
   open and merge its pull request into main before the next step.
4. Open Settings > Pages. Under Build and deployment, choose:
   - Source: Deploy from a branch
   - Branch: main
   - Folder: /(root)
   Then Save.
5. Wait for the deployment. GitHub says publication can take up to 10 minutes.
   Return to Settings > Pages and use Visit site. Your public address will be:
   `https://YOUR-USERNAME.github.io/parcours/`

If your computer hides `.nojekyll`, you can create it with Add file > Create new
file on GitHub, name it `.nojekyll`, and commit it. This tells Pages to serve
these already-built files without a Jekyll build.

## What is included

- index.html: app, styles, curriculum and JavaScript
- assets/: the existing cat icons
- manifest.webmanifest: web-app metadata and relative-path icons
- sw.js: existing offline app-shell worker
- .nojekyll: use the static files directly
- README.md: these instructions

## Privacy and existing progress

The public repository exposes the bundled app code, lesson materials and example
corrections. Do not upload passwords, API keys, personal backup JSON files, or
private tutor exports. Your later progress and notes are stored by the app in
your browser, not committed to this repository or synced to GitHub.

Before switching from your downloaded app, export a backup from its Settings &
backup screen. Open the new hosted site and import the backup there. Keep backup
files on your own device. Your laptop and phone do not automatically sync.

## Verification and limits

The deployable app files in this package are byte-for-byte unchanged from the
latest ready-to-publish package. This packaging adds only this README and the
.nojekyll file, and removes Netlify-specific instructions/headers. All local app
asset references use relative paths suitable for a project site at /parcours/.
Actual GitHub deployment and phone home-screen installation still need to be
checked after you publish. Streaming availability remains provider-dependent.

## Official instructions checked 27 September 2026

- https://docs.github.com/en/pages/getting-started-with-github-pages/what-is-github-pages
- https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site
- https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site
- https://docs.github.com/en/repositories/working-with-files/managing-files/adding-a-file-to-a-repository
