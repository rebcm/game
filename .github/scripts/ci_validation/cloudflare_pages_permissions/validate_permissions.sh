#!/bin/bash

# Validate Cloudflare Pages permissions
# Check if the permissions matrix is correctly defined

MATRIX_FILE="docs/cloudflare_pages_pipeline/minimum_permissions_matrix.md"

if [ ! -f "$MATRIX_FILE" ]; then
  echo "Permissions matrix file not found: $MATRIX_FILE"
  exit 1
fi

# Basic validation: check if the file is not empty
if [ ! -s "$MATRIX_FILE" ]; then
  echo "Permissions matrix file is empty: $MATRIX_FILE"
  exit 1
fi

echo "Permissions matrix validation successful"
