#!/bin/bash

URL="https://rebcm.pages.dev"
STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" $URL)

if [ "$STATUS_CODE" -eq 200 ]; then
  echo "Smoke test passed: $URL returned $STATUS_CODE"
  exit 0
else
  echo "Smoke test failed: $URL returned $STATUS_CODE"
  exit 1
fi
