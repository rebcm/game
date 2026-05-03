#!/bin/bash

# Get the minimum Flutter version from pubspec.yaml
MIN_FLUTTER_VERSION=$(grep 'flutter: ">=3.' pubspec.yaml | sed 's/.*flutter: ">=\(.*\)"/\1/')

# Extract major, minor, and patch versions
IFS='.' read -r -a version_parts <<< "$MIN_FLUTTER_VERSION"
MAJOR_VERSION=${version_parts[0]}
MINOR_VERSION=${version_parts[1]}

# Flutter version to Android API Level mapping (based on Flutter documentation)
if (( MINOR_VERSION >= 16 )); then
  MIN_ANDROID_API_LEVEL=21
elif (( MINOR_VERSION >= 10 )); then
  MIN_ANDROID_API_LEVEL=19
else
  MIN_ANDROID_API_LEVEL=16
fi

# Flutter version to iOS version mapping (based on Flutter documentation)
if (( MINOR_VERSION >= 16 )); then
  MIN_IOS_VERSION=12.0
elif (( MINOR_VERSION >= 10 )); then
  MIN_IOS_VERSION=11.0
else
  MIN_IOS_VERSION=9.0
fi

# Output the results
echo "Minimum Flutter Version: $MIN_FLUTTER_VERSION"
echo "Minimum Android API Level: $MIN_ANDROID_API_LEVEL"
echo "Minimum iOS Version: $MIN_IOS_VERSION"

# Save the results to a file for later use in the CI pipeline
mkdir -p .github/scripts/ci_validation/flutter_sdk_versions/output
cat > .github/scripts/ci_validation/flutter_sdk_versions/output/min_versions.txt << EOF_MIN_VERSIONS
MIN_FLUTTER_VERSION=$MIN_FLUTTER_VERSION
MIN_ANDROID_API_LEVEL=$MIN_ANDROID_API_LEVEL
MIN_IOS_VERSION=$MIN_IOS_VERSION
EOF_MIN_VERSIONS
