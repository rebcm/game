#!/bin/bash

# Validate keystore recovery
echo "Validating keystore recovery..."

# Run the key recovery script
bash .github/scripts/key_recovery/recover_key.sh

# Check if keystore.jks exists
if [ -f keystore.jks ]; then
  echo "Keystore recovery validated successfully."
else
  echo "Failed to validate keystore recovery."
  exit 1
fi
