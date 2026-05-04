#!/bin/bash

# Build the Flutter app
flutter build apk

# Calculate the checksum of the generated APK
APK_CHECKSUM=$(sha256sum build/app/outputs/flutter-apk/app-release.apk | cut -d' ' -f1)

# Compare the checksum with the expected value
EXPECTED_CHECKSUM=$(cat .github/docs/expected_checksum.txt)
if [ "$APK_CHECKSUM" != "$EXPECTED_CHECKSUM" ]; then
  echo "Checksum mismatch: expected $EXPECTED_CHECKSUM, got $APK_CHECKSUM"
  exit 1
fi
