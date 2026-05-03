# Configuring Secrets for GitHub Actions

To configure secrets for GitHub Actions, follow these steps:

1. Go to your repository settings on GitHub.
2. Click on "Actions" in the left sidebar.
3. Click on "Secrets" and then "Actions".
4. Click on "New repository secret".
5. Add the following secrets:
   - `CLOUDFLARE_API_TOKEN`
   - `CLOUDFLARE_ACCOUNT_ID`

These secrets are required for the CI/CD pipeline to authenticate with Cloudflare.
