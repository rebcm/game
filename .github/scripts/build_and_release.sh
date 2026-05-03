#!/bin/bash

# Build the Flutter project
flutter build web

# Deploy to Cloudflare Pages
curl -X POST \
  https://api.cloudflare.com/client/v4/accounts/$CLOUDFLARE_ACCOUNT_ID/pages/projects/your_project_name/deployments \
  -H 'Authorization: Bearer '$CLOUDFLARE_API_TOKEN \
  -H 'Content-Type: application/json' \
  -d '{"branch": "main", "working_directory": "/"}'
