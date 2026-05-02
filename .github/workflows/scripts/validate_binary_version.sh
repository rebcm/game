#!/bin/bash

BINARY_VERSION=$(flutter build apk --release --verbose | grep "versionName" | awk '{print $2}')
if [ "$BINARY_VERSION" != "1.0.0" ]; then
  echo "Binary version mismatch: expected 1.0.0, got $BINARY_VERSION"
  exit 1
fi
