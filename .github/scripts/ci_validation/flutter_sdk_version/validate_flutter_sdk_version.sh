#!/bin/bash

# Script to validate Flutter SDK version against minimum supported versions

# Get current Flutter SDK version
FLUTTER_VERSION=$(flutter --version | grep "Flutter" | cut -d' ' -f2)

# Minimum supported versions for Android and iOS
MIN_ANDROID_API_LEVEL=21
MIN_IOS_VERSION=12.0

# Check if Flutter version supports the minimum Android API level
ANDROID_SUPPORT=$(flutter doctor | grep "Android SDK" | cut -d' ' -f4)

if [ $ANDROID_SUPPORT -ge $MIN_ANDROID_API_LEVEL ]; then
  echo "Android API Level $MIN_ANDROID_API_LEVEL is supported"
else
  echo "Error: Android API Level $MIN_ANDROID_API_LEVEL is not supported"
  exit 1
fi

# Check if Flutter version supports the minimum iOS version
IOS_SUPPORT=$(flutter doctor | grep "iOS" | grep -o "ios-deploy")

if [ $(echo "$IOS_SUPPORT" | cut -d'.' -f1) -ge $MIN_IOS_VERSION ]; then
  echo "iOS version $MIN_IOS_VERSION is supported"
else
  echo "Error: iOS version $MIN_IOS_VERSION is not supported"
  exit 1
fi

echo "Flutter SDK version $FLUTTER_VERSION is compatible with minimum supported versions"
