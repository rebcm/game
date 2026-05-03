#!/bin/bash

if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
  echo "Cloudflare API token is not set"
  exit 1
fi

