#!/bin/bash

# Get the current Flutter SDK version
FLUTTER_VERSION=$(flutter --version | grep "Flutter" | cut -d ' ' -f2)

# Define the minimum supported Android API level and iOS version based on the Flutter SDK version
case $FLUTTER_VERSION in
  3.0.*)
    MIN_ANDROID_API_LEVEL=21
    MIN_IOS_VERSION=12.0
    ;;
  3.3.*)
    MIN_ANDROID_API_LEVEL=21
    MIN_IOS_VERSION=12.0
    ;;
  *)
    MIN_ANDROID_API_LEVEL=19
    MIN_IOS_VERSION=11.0
    ;;
esac

# Validate the minimum supported versions against the project's configuration
if [ -f "android/app/build.gradle" ]; then
  ANDROID_API_LEVEL=$(grep "minSdkVersion" android/app/build.gradle | cut -d '=' -f2- | tr -d '[:space:]')
  if [ $ANDROID_API_LEVEL -lt $MIN_ANDROID_API_LEVEL ]; then
    echo "Error: Android API level $ANDROID_API_LEVEL is lower than the minimum required $MIN_ANDROID_API_LEVEL for Flutter $FLUTTER_VERSION"
    exit 1
  fi
fi

if [ -f "ios/Podfile" ]; then
  IOS_VERSION=$(grep "platform :ios, '" ios/Podfile | cut -d "'" -f2)
  if [ $(printf '%s\n' "$IOS_VERSION" "$MIN_IOS_VERSION" | sort -V | head -n1) != "$MIN_IOS_VERSION" ]; then
    echo "Error: iOS version $IOS_VERSION is lower than the minimum required $MIN_IOS_VERSION for Flutter $FLUTTER_VERSION"
    exit 1
  fi
fi

echo "Flutter SDK version $FLUTTER_VERSION is compatible with the project's configuration"
