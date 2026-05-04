#!/bin/bash

# Mock curl command to test the script
mock_curl() {
  echo '{"result":{"id":"123","status":"active"}}'
}

# Load the script to be tested
source scripts/validate_cloudflare_token.sh

# Test the script
CLOUDFLARE_API_TOKEN="test_token" validate_cloudflare_token.sh

