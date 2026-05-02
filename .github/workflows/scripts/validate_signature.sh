#!/bin/bash

validate_android_signature() {
  APK_PATH=$1
  if ! apksigner verify --verbose "$APK_PATH" > /dev/null; then
    echo "Android APK signature validation failed for $APK_PATH"
    return 1
  fi
  echo "Android APK signature validated successfully for $APK_PATH"
}

validate_ios_signature() {
  IPA_PATH=$1
  if ! codesign --verify --verbose "$IPA_PATH" > /dev/null; then
    echo "iOS IPA signature validation failed for $IPA_PATH"
    return 1
  fi
  echo "iOS IPA signature validated successfully for $IPA_PATH"
}

validate_android_signature "$1"
