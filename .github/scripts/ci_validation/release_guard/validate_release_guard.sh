#!/bin/bash

RELEASE_TAG=$(git describe --tags --abbrev=0)

if [ -n "$RELEASE_TAG" ]; then
  echo "Release tag detected: $RELEASE_TAG"
  # Logic to protect artifacts marked with release tags
  # For example, setting an environment variable to skip deletion
  export PROTECT_RELEASE_ARTIFACTS=true
else
  echo "No release tag detected"
  export PROTECT_RELEASE_ARTIFACTS=false
fi
