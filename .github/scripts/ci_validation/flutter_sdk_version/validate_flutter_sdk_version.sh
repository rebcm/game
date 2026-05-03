#!/bin/bash

# Get the minimum supported Flutter SDK version from pubspec.yaml
MIN_SDK_VERSION=$(grep 'sdk:' pubspec.yaml | awk -F '"' '{print $2}' | sed 's/>=//')

# Extract major, minor, and patch versions
IFS='.' read -r -a VERSION_PARTS <<< "$MIN_SDK_VERSION"
MAJOR=${VERSION_PARTS[0]}
MINOR=${VERSION_PARTS[1]}

# Determine the minimum supported Android API Level and iOS version based on the Flutter SDK version
if (( MAJOR == 3 )); then
  MIN_ANDROID_API_LEVEL=19
  MIN_IOS_VERSION=12.0
elif (( MAJOR == 2 && MINOR >= 17 )); then
  MIN_ANDROID_API_LEVEL=19
  MIN_IOS_VERSION=11.0
else
  echo "Unsupported Flutter SDK version: $MIN_SDK_VERSION"
  exit 1
fi

# Output the results
echo "Minimum Android API Level: $MIN_ANDROID_API_LEVEL"
echo "Minimum iOS Version: $MIN_IOS_VERSION"

# Save the results to a file for later use
mkdir -p .github/scripts/ci_validation/flutter_sdk_version/output
cat > .github/scripts/ci_validation/flutter_sdk_version/output/min_versions.txt << EOF
MIN_ANDROID_API_LEVEL=$MIN_ANDROID_API_LEVEL
MIN_IOS_VERSION=$MIN_IOS_VERSION
