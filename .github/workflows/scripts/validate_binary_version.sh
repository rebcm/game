#!/bin/bash

BINARY_PATH=$1

if [ ! -f "$BINARY_PATH" ]; then
  echo "Binary not found: $BINARY_PATH"
  exit 1
fi

# Assuming the binary is a Flutter APK, we can use aapt to get its version
VERSION_CODE=$(aapt dump badging "$BINARY_PATH" | grep "versionCode" | cut -d "'" -f 2)
VERSION_NAME=$(aapt dump badging "$BINARY_PATH" | grep "versionName" | cut -d "'" -f 2)

if [ "$VERSION_CODE" != "$(grep "version:" pubspec.yaml | cut -d ":" -f 2 | tr -d " ")" ]; then
  echo "Version code mismatch: expected $(grep "version:" pubspec.yaml | cut -d ":" -f 2 | tr -d " "), got $VERSION_CODE"
  exit 1
fi

if [ "$VERSION_NAME" != "$(grep "version:" pubspec.yaml | cut -d ":" -f 2 | cut -d "+" -f 1 | tr -d " ")" ]; then
  echo "Version name mismatch: expected $(grep "version:" pubspec.yaml | cut -d ":" -f 2 | cut -d "+" -f 1 | tr -d " "), got $VERSION_NAME"
  exit 1
fi

echo "Binary version validated successfully"
