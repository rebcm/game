#!/bin/bash

source ./.github/scripts/ci_validation/cloudflare_token_validation/validate_cloudflare_token.sh

TOKEN="valid_token"
ZONE_ID="zone_id"

if validate_cloudflare_token.sh $TOKEN $ZONE_ID; then
  echo "Test passed"
else
  echo "Test failed"
  exit 1
fi

TOKEN="invalid_token"
if ! validate_cloudflare_token.sh $TOKEN $ZONE_ID; then
  echo "Test passed"
else
  echo "Test failed"
  exit 1
fi
