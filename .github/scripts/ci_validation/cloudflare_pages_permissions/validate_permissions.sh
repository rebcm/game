#!/bin/bash

TOKEN=$CLOUDFLARE_API_TOKEN
ZONE_ID=$CLOUDFLARE_ZONE_ID

bash .github/scripts/ci_validation/token_validation/validate_token.sh $TOKEN $ZONE_ID
