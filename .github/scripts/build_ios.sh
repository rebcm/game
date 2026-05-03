#!/bin/bash

# Set environment variables
export FLUTTER_VERSION=$(flutter --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')

# Validate Flutter version
./.github/scripts/validate_flutter_version.sh

# Build IPA
flutter build ipa --release --export-options-plist=.github/scripts/ExportOptions.plist

# Upload artifact
