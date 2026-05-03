#!/bin/bash

# Recover keystore from GitHub Secrets
echo "Recovering keystore..."

# Decode Base64 encoded keystore
echo $KEYSTORE_BASE64 | base64 --decode > keystore.jks

# Verify keystore recovery
if [ -f keystore.jks ]; then
  echo "Keystore recovered successfully."
else
  echo "Failed to recover keystore."
  exit 1
fi
