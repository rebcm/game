#!/bin/bash

PREVIEW_URL=$1

response_code=$(curl -s -o /dev/null -w "%{http_code}" $PREVIEW_URL)

if [ "$response_code" -eq 200 ]; then
  echo "Preview URL is accessible"
  exit 0
else
  echo "Preview URL is not accessible"
  exit 1
fi
