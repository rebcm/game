#!/bin/bash

# Load environment variables
source .env

# Check if notification URL is set
if [ -z "$NOTIFICATION_URL" ]; then
  echo "NOTIFICATION_URL is not set in .env file"
  exit 1
fi

# Check if test failed
if [ "$1" = "failed" ]; then
  # Send notification to the specified URL
  curl -X POST -H "Content-Type: application/json" -d '{"text": "Smoke test failed after deploy"}' $NOTIFICATION_URL
  echo "Notification sent to $NOTIFICATION_URL"
else
  echo "Test passed, no notification sent"
fi
