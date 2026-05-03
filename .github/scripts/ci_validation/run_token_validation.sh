#!/bin/bash

TOKEN=$(cat .env | grep CLOUDFLARE_TOKEN | cut -d '=' -f2-)

.github/scripts/ci_validation/token_validation/validate_token.sh "$TOKEN"
