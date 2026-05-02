#!/bin/bash

if [ -z "$CLOUDFLARE_API_TOKEN" ] || [ -z "$CLOUDFLARE_ACCOUNT_ID" ]; then
  echo "Cloudflare secrets are not set"
  exit 1
else
  echo "Cloudflare secrets are set correctly"
fi
