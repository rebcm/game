#!/bin/bash

# Get the current Flutter version
FLUTTER_VERSION=$(flutter --version | grep "Flutter" | cut -d' ' -f2)

# Extract the minimum supported Android and iOS versions based on the Flutter version
MIN_ANDROID_VERSION=$(flutter doctor --verbose | grep "Android SDK version" | cut -d' ' -f5-)
MIN_IOS_VERSION=$(grep -r 'MinimumOSVersion' ios/Podfile.lock | cut -d' ' -f2)

echo "Current Flutter version: $FLUTTER_VERSION"
echo "Minimum Android version supported: $MIN_ANDROID_VERSION"
echo "Minimum iOS version supported: $MIN_IOS_VERSION"

# Save the results to a file for further processing or logging
echo "$FLUTTER_VERSION,$MIN_ANDROID_VERSION,$MIN_IOS_VERSION" > flutter_min_sdk_versions.txt
