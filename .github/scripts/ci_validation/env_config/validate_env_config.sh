#!/bin/bash

# Validate if necessary environment variables are set
if [ -z "$WRANGLER_API_TOKEN" ] || [ -z "$DATABASE_URL" ]; then
  echo "Error: Environment variables WRANGLER_API_TOKEN or DATABASE_URL are not set."
  exit 1
fi
