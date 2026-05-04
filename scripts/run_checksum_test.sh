#!/bin/bash

# Compile the Flutter app
flutter build apk

# Calculate the checksum of the generated APK
CHECKSUM=$(sha256sum build/app/outputs/flutter-apk/app-release.apk | cut -d' ' -f1)

# Compare the calculated checksum with the expected checksum
EXPECTED_CHECKSUM=$(cat .github/docs/expected_checksum.txt)
if [ "$CHECKSUM" != "$EXPECTED_CHECKSUM" ]; then
  echo "Checksum mismatch: expected $EXPECTED_CHECKSUM, got $CHECKSUM"
  exit 1
fi
