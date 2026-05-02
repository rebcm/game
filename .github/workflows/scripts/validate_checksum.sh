#!/bin/bash

ARTIFACT_DIR=$1

# Calculate checksum for each artifact
for file in "$ARTIFACT_DIR"/*; do
  echo "Calculating checksum for $file"
  sha256sum "$file" > "$file.sha256"
done

# Verify checksum for each artifact
for file in "$ARTIFACT_DIR"/*; do
  if [ -f "$file.sha256" ]; then
    echo "Verifying checksum for $file"
    sha256sum -c "$file.sha256"
    if [ $? -ne 0 ]; then
      echo "Checksum verification failed for $file"
      exit 1
    fi
  fi
done
