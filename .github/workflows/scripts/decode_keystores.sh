#!/bin/bash

# Decode Base64 encoded secrets back to binary files
echo "Decoding keystores from Base64..."

# Check if secrets are set
if [ -z "$KEYSTORE_JKS_BASE64" ] || [ -z "$KEYSTORE_P12_BASE64" ]; then
  echo "Error: Keystore secrets are not set."
  exit 1
fi

# Decode and save keystores
echo "$KEYSTORE_JKS_BASE64" | base64 --decode > android/app/keystore.jks
echo "$KEYSTORE_P12_BASE64" | base64 --decode > ios/keystore.p12

echo "Keystores decoded successfully."
