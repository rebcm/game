#!/bin/bash

URL=$1
RETRIES=3
DELAY=5

for ((i=0; i<$RETRIES; i++)); do
  STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" $URL)
  if [ $STATUS_CODE -eq 200 ]; then
    echo "Deploy validation successful: $URL returned 200"
    exit 0
  else
    echo "Attempt $((i+1)) failed: $URL returned $STATUS_CODE. Retrying in $DELAY seconds..."
    sleep $DELAY
  fi
done

echo "Deploy validation failed after $RETRIES attempts: $URL did not return 200"
exit 1
