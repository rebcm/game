#!/bin/bash

echo "Running CI validation..."

# Clean and get dependencies
flutter clean
flutter pub get

# Run static analysis
dart analyze

if [ $? -eq 0 ]; then
  echo "CI validation successful."
else
  echo "CI validation failed."
  exit 1
fi
