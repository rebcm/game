#!/bin/bash

source .github/scripts/ci_validation/cloudflare_token_validation/scripts/validate_cloudflare_token.sh

# Test with valid token
TOKEN="valid_token"
ZONE_ID="zone_id"
if validate_cloudflare_token.sh $TOKEN $ZONE_ID; then
  echo "Test passed: Valid token"
else
  echo "Test failed: Valid token"
  exit 1
fi

# Test with invalid token
TOKEN="invalid_token"
ZONE_ID="zone_id"
if ! validate_cloudflare_token.sh $TOKEN $ZONE_ID; then
  echo "Test passed: Invalid token"
else
  echo "Test failed: Invalid token"
  exit 1
fi
