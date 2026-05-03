#!/bin/bash

# Load environment variables from .env file
set -a
source .env
set +a

# Check if required variables are set
if [ -z "$DISCORD_WEBHOOK_URL" ]; then
  echo "DISCORD_WEBHOOK_URL is not set in .env file"
  exit 1
fi

# Send notification to Discord
curl -X POST \
  $DISCORD_WEBHOOK_URL \
  -H 'Content-Type: application/json' \
  -d '{"content": "Daily build at 20:00 BRT has failed."}'
