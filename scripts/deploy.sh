#!/bin/bash

# Authenticate with Cloudflare using the API token
wrangler config --api-token ${CLOUDFLARE_API_TOKEN}

# Deploy to Cloudflare
wrangler publish
