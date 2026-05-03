#!/bin/bash

TOKEN=$1
ZONE_ID=$2

bash .github/scripts/ci_validation/token_validation/validate_token.sh $TOKEN $ZONE_ID
