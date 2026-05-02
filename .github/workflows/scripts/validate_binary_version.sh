#!/bin/bash

ARTIFACT_DIR=$1
VERSION_FILE="${ARTIFACT_DIR}/version.txt"

if [ ! -f "$VERSION_FILE" ]; then
  echo "Version file not found"
  exit 1
fi

VERSION=$(cat "$VERSION_FILE")
if ! [[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Invalid version format"
  exit 1
fi

echo "Version is valid: $VERSION"
