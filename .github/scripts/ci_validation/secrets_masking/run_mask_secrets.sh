#!/bin/bash

# Load secrets from environment variables
secrets=("$SECRET1" "$SECRET2" "$CLOUDFLARE_API_TOKEN")

# Call the mask_secrets function with the loaded secrets
mask_secrets "${secrets[@]}" < .github/scripts/build_and_release.sh
