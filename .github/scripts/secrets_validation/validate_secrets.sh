#!/bin/bash

# Validate if keystores/certs are being injected via Secrets
if [ -z "$KEYSTORE_PATH" ] || [ -z "$KEYSTORE_PASSWORD" ]; then
  echo "Error: Keystore path or password not set"
  exit 1
fi

if [ ! -f "$KEYSTORE_PATH" ]; then
  echo "Error: Keystore file not found"
  exit 1
fi
