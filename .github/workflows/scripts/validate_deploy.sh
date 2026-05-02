#!/bin/bash

URL=$1
RETRIES=3
DELAY=5

for ((i=0; i<$RETRIES; i++)); do
  STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" $URL)
  if [ $STATUS_CODE -eq 200 ]; then
    echo "Deploy validated successfully: $URL"
    exit 0
  else
    echo "Attempt $((i+1)) failed with status code $STATUS_CODE. Retrying in $DELAY seconds..."
    sleep $DELAY
  fi
done

echo "Failed to validate deploy after $RETRIES attempts: $URL"
exit 1
