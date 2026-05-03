#!/bin/bash

# Validate that the necessary GitHub Secrets are set.

if [ -z "${CLOUDFLARE_API_TOKEN}" ]; then
  echo "CLOUDFLARE_API_TOKEN secret is not set."
  exit 1
fi

if [ -z "${CLOUDFLARE_ACCOUNT_ID}" ]; then
  echo "CLOUDFLARE_ACCOUNT_ID secret is not set."
  exit 1
fi

echo "All necessary secrets are set."

