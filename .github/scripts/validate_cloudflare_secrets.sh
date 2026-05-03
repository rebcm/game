#!/bin/bash

if [ -z "$CLOUDFLARE_ACCOUNT_ID" ] || [ -z "$CLOUDFLARE_PAGES_PROJECT_NAME" ]; then
  echo "Cloudflare secrets are not set"
  exit 1
fi
