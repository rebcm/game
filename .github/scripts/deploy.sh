#!/bin/bash

# Exit on error
set -e

# Check if WRANGLER_TOKEN and WRANGLER_ACCOUNT_ID are set
if [ -z "$WRANGLER_TOKEN" ] || [ -z "$WRANGLER_ACCOUNT_ID" ]; then
  echo "WRANGLER_TOKEN and WRANGLER_ACCOUNT_ID must be set"
  exit 1
fi

# Deploy to production
wrangler publish --token $WRANGLER_TOKEN --account-id $WRANGLER_ACCOUNT_ID
