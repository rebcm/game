#!/bin/bash

source ./.github/scripts/ci_validation/cloudflare_token_validation/validate_cloudflare_token.sh

test_valid_token() {
  CLOUDFLARE_TOKEN="valid_token"
  ZONE_ID="zone_id"

  # Mock curl response
  curl() {
    echo '{"result":{"permissions":["Zone.DNS","Zone.Settings"]}}'
  }

  if validate_token; then
    echo "Test passed: valid token"
  else
    echo "Test failed: valid token"
    exit 1
  fi
}

test_invalid_token() {
  CLOUDFLARE_TOKEN="invalid_token"
  ZONE_ID="zone_id"

  # Mock curl response
  curl() {
    echo '{"result":{"permissions":[]}}'
  }

  if ! validate_token; then
    echo "Test passed: invalid token"
  else
    echo "Test failed: invalid token"
    exit 1
  fi
}

test_valid_token
test_invalid_token
