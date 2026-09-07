# PinForge Pinterest Publisher V1

GitHub-ready Cloudflare Worker + D1 Pinterest publisher.

## V1
- Stable internal IDs: `pinterest_01`, `pinterest_02`, ...
- Official Pinterest OAuth 2.0 connection
- Automatically stores Pinterest user ID/username
- XLSX/CSV import in browser
- Explicit approval before scheduling
- Select All approval per imported file
- Queue by `publish_date`
- Official Pinterest image Pin creation
- Account pause on 401/403
- Queue/history data in D1
- OAuth tokens encrypted with AES-GCM

## Deployment
1. Create/obtain Pinterest Trial access and app credentials.
2. Create a Cloudflare Worker and D1 database.
3. Put this repo in GitHub.
4. Apply `migrations/0001_initial.sql` to D1.
5. Set Worker secrets: `PINTEREST_CLIENT_ID`, `PINTEREST_CLIENT_SECRET`, `TOKEN_ENCRYPTION_KEY` (32-byte base64).
6. Set `APP_BASE_URL` to the exact public Worker URL.
7. In Pinterest My Apps add `APP_BASE_URL/api/oauth/callback` as a redirect URI.
8. Protect the dashboard with Cloudflare Access (recommended for this single-owner V1).
9. Deploy from GitHub Actions.

## PinForge XLSX minimum columns
`pinterest_account_id`, `publish_date`, `title`, `image_url`.

Recommended: `description`, `destination_url`, `board_id`, `board`, `section_id`, `section`, `alt_text`.

OAuth tokens never belong in XLSX.

## Important Pinterest compliance design
Importing a file never publishes Pins. The owner must explicitly approve the Pins. `Select All` approves the entire file in one user action.
