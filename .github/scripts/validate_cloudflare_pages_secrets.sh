#!/bin/bash

if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
  echo "CLOUDFLARE_API_TOKEN is not set"
  exit 1
fi

if [ -z "$CLOUDFLARE_ACCOUNT_ID" ]; then
  echo "CLOUDFLARE_ACCOUNT_ID is not set"
  exit 1
fi

if [ -z "$CLOUDFLARE_PROJECT_NAME" ]; then
  echo "CLOUDFLARE_PROJECT_NAME is not set"
  exit 1
fi
