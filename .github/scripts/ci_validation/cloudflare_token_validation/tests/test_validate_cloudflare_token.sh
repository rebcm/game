#!/bin/bash

source ../validate_cloudflare_token.sh

# Test cases
TOKEN_VALID="valid_token"
ZONE_ID="zone_id"

# Mock curl response
curl() {
  echo '{"result":{"permissions":{"Zone.DNS":"edit","Zone.Settings":"edit"}}}'
}

TOKEN=$TOKEN_VALID ZONE_ID=$ZONE_ID ../validate_cloudflare_token.sh $TOKEN $ZONE_ID
if [ $? -eq 0 ]; then
  echo "Test passed: valid token"
else
  echo "Test failed: valid token"
  exit 1
fi

TOKEN_INVALID="invalid_token"

# Mock curl response
curl() {
  echo '{"result":{"permissions":{"Zone.DNS":"read","Zone.Settings":"read"}}}'
}

TOKEN=$TOKEN_INVALID ZONE_ID=$ZONE_ID ../validate_cloudflare_token.sh $TOKEN $ZONE_ID
if [ $? -eq 1 ]; then
  echo "Test passed: invalid token"
else
  echo "Test failed: invalid token"
  exit 1
fi
