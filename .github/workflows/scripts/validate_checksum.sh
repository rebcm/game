#!/bin/bash

ARTIFACT_DIR=$1
CHECKSUM_FILE="${ARTIFACT_DIR}/checksums.sha256"

if [ ! -f "$CHECKSUM_FILE" ]; then
  echo "Checksum file not found"
  exit 1
fi

cd "$ARTIFACT_DIR"
sha256sum -c checksums.sha256
