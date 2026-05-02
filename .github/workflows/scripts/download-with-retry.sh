#!/bin/bash

URL=$1
OUTPUT=$2
MAX_RETRIES=${3:-3}

retry_count=0
while [ $retry_count -lt $MAX_RETRIES ]; do
  if curl -f -o $OUTPUT $URL; then
    echo "Download successful: $URL"
    exit 0
  else
    retry_count=$((retry_count + 1))
    echo "Download failed (attempt $retry_count/$MAX_RETRIES): $URL"
    sleep 2
  fi
done

echo "Download failed after $MAX_RETRIES attempts: $URL"
exit 1
