#!/bin/bash

CHECKSUM=$(sha256sum build/app/outputs/flutter-apk/app-release.apk | awk '{print $1}')
if [ "$CHECKSUM" != "expected_checksum" ]; then
  echo "Checksum mismatch: expected expected_checksum, got $CHECKSUM"
  exit 1
fi
