#!/bin/bash

if [ -z "$CLOUDFLARE_ACCOUNT_ID" ] || [ -z "$CLOUDFLARE_API_TOKEN" ] || [ -z "$CLOUDFLARE_PAGES_PROJECT_NAME" ]; then
  echo "Cloudflare Pages secrets are not set"
  exit 1
fi
