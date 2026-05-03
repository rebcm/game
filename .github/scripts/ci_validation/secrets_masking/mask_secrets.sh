#!/bin/bash

# Load secrets from .env file
set -a; source .env; set +a

# Mask sensitive values in GitHub Actions logs
echo "::add-mask::$CLOUDFLARE_API_TOKEN"
echo "::add-mask::$CLOUDFLARE_ACCOUNT_ID"
echo "::add-mask::$PAGES_API_TOKEN"

# Add more secrets to mask as needed
