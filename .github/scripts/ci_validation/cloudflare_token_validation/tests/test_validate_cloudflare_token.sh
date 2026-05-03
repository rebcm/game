#!/bin/bash

source ../../../../.env

CLOUDFLARE_TOKEN=$CLOUDFLARE_TOKEN
ZONE_ID=$ZONE_ID

bash ../validate_cloudflare_token.sh $CLOUDFLARE_TOKEN $ZONE_ID
