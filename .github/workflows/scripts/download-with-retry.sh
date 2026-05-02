#!/bin/bash

URL=$1
OUTPUT=$2
MAX_RETRIES=${3:-3}
RETRY_DELAY=${4:-5}

for ((i=0; i<MAX_RETRIES; i++)); do
  if curl -f -o "$OUTPUT" "$URL"; then
    echo "Download successful: $URL"
    exit 0
  else
    echo "Download failed (attempt $((i+1))/$MAX_RETRIES): $URL"
    if (( i < MAX_RETRIES - 1 )); then
      sleep "$RETRY_DELAY"
    fi
  fi
done

echo "Download failed after $MAX_RETRIES attempts: $URL"
exit 1
