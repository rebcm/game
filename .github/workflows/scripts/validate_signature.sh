#!/bin/bash

validate_android_signature() {
  if ! command -v apksigner &> /dev/null; then
    echo "Error: apksigner not found"
    return 1
  fi

  APK_SIGNER_OUTPUT=$(apksigner verify --verbose "$1" 2>&1)
  if echo "$APK_SIGNER_OUTPUT" | grep -q "Verified using v1 scheme (JAR signing)"; then
    echo "Android APK signature valid"
    return 0
  else
    echo "Android APK signature invalid"
    return 1
  fi
}

validate_ios_signature() {
  if ! command -v codesign &> /dev/null; then
    echo "Error: codesign not found"
    return 1
  fi

  CODESIGN_OUTPUT=$(codesign --verify --verbose "$1" 2>&1)
  if echo "$CODESIGN_OUTPUT" | grep -q "valid on disk"; then
    echo "iOS IPA signature valid"
    return 0
  else
    echo "iOS IPA signature invalid"
    return 1
  fi
}

validate_android_checksum() {
  if ! command -v sha256sum &> /dev/null; then
    echo "Error: sha256sum not found"
    return 1
  fi

  EXPECTED_CHECKSUM="$2"
  ACTUAL_CHECKSUM=$(sha256sum "$1" | cut -d' ' -f1)
  if [ "$EXPECTED_CHECKSUM" = "$ACTUAL_CHECKSUM" ]; then
    echo "Android APK checksum valid"
    return 0
  else
    echo "Android APK checksum invalid"
    return 1
  fi
}

validate_ios_checksum() {
  if ! command -v sha256sum &> /dev/null; then
    echo "Error: sha256sum not found"
    return 1
  fi

  EXPECTED_CHECKSUM="$2"
  ACTUAL_CHECKSUM=$(sha256sum "$1" | cut -d' ' -f1)
  if [ "$EXPECTED_CHECKSUM" = "$ACTUAL_CHECKSUM" ]; then
    echo "iOS IPA checksum valid"
    return 0
  else
    echo "iOS IPA checksum invalid"
    return 1
  fi
}

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <platform> <file> [checksum]"
  exit 1
fi

PLATFORM="$1"
FILE="$2"
CHECKSUM="$3"

case "$PLATFORM" in
  android)
    if [ -n "$CHECKSUM" ]; then
      validate_android_checksum "$FILE" "$CHECKSUM"
    else
      validate_android_signature "$FILE"
    fi
    ;;
  ios)
    if [ -n "$CHECKSUM" ]; then
      validate_ios_checksum "$FILE" "$CHECKSUM"
    else
      validate_ios_signature "$FILE"
    fi
    ;;
  *)
    echo "Unsupported platform: $PLATFORM"
    exit 1
    ;;
esac
