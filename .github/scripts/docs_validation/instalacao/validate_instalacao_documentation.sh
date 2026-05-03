#!/bin/bash

# Validate installation documentation
echo "Validating installation documentation..."

# Check if README.md exists
if [ ! -f ./README.md ]; then
  echo "README.md not found."
  exit 1
fi

# Check if README.md contains installation instructions
if ! grep -q "## Instalação" ./README.md; then
  echo "Installation instructions not found in README.md."
  exit 1
fi

# Check if installation instructions contain common error solutions
if ! grep -q "CocoaPods" ./README.md; then
  echo "CocoaPods error solution not found in README.md."
  exit 1
fi

if ! grep -q "Android Studio" ./README.md; then
  echo "Android Studio error solution not found in README.md."
  exit 1
fi

echo "Installation documentation validated successfully."
