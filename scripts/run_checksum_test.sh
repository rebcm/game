#!/bin/bash

# Generate the checksum for the current build
flutter build apk
checksum=$(sha256sum build/app/outputs/flutter-apk/app-release.apk | cut -d' ' -f1)

# Compare with expected checksum
expected_checksum=$(cat .github/docs/expected_checksum.txt)
if [ "$checksum" != "$expected_checksum" ]; then
  echo "Checksum mismatch: expected $expected_checksum, got $checksum"
  exit 1
fi
