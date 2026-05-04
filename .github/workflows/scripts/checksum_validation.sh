#!/bin/bash

# Store the path to the current binary
CURRENT_BINARY_PATH="build/app/outputs/flutter-apk/app-release.apk"

# Check if the binary exists
if [ ! -f "$CURRENT_BINARY_PATH" ]; then
  echo "Error: Binary not found at $CURRENT_BINARY_PATH"
  exit 1
fi

# Calculate the checksum of the current binary
CURRENT_CHECKSUM=$(sha256sum "$CURRENT_BINARY_PATH" | cut -d' ' -f1)

# Load the expected checksum from the file
EXPECTED_CHECKSUM_FILE=".github/docs/expected_checksum.txt"

# Check if the expected checksum file exists
if [ ! -f "$EXPECTED_CHECKSUM_FILE" ]; then
  echo "Error: Expected checksum file not found at $EXPECTED_CHECKSUM_FILE"
  exit 1
fi

# Load the expected checksum
EXPECTED_CHECKSUM=$(cat "$EXPECTED_CHECKSUM_FILE")

# Compare the checksums
if [ "$CURRENT_CHECKSUM" != "$EXPECTED_CHECKSUM" ]; then
  echo "Error: Checksum mismatch. Current: $CURRENT_CHECKSUM, Expected: $EXPECTED_CHECKSUM"
  exit 1
fi

echo "Checksum validation successful."
