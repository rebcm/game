#!/bin/bash

# Install wrangler if not already installed
if ! command -v wrangler &> /dev/null; then
  npm install -g wrangler
fi

# Deploy to Cloudflare
wrangler pages deploy build/web --project-name=rebcm-game
