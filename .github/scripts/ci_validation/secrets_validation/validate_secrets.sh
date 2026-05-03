#!/bin/bash

# Validate if keystores/certs are being injected via Secrets
if [ -z "$KEYSTORE_FILE" ] || [ -z "$KEYSTORE_PASSWORD" ]; then
  echo "Error: Keystore secrets are not properly set."
  exit 1
fi

if [ ! -f "keystores/keystore.jks" ]; then
  echo "Error: Keystore file is not present."
  exit 1
fi
