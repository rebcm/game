#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
  export $(cat .env | xargs)
else
  echo ".env file not found"
  exit 1
fi

# Check if notification token is set
if [ -z "$NOTIFICATION_TOKEN" ]; then
  echo "NOTIFICATION_TOKEN is not set in .env"
  exit 1
fi

# Send notification
curl -X POST \
  https://api.example.com/notify \
  -H 'Content-Type: application/json' \
  -d '{"token": "'"$NOTIFICATION_TOKEN"'", "message": "Build failed"}'
