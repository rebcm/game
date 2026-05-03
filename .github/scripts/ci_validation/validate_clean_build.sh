#!/bin/bash

echo "Validating clean build..."

# Clean and get dependencies
flutter clean
flutter pub get

# Check if there are any errors after getting dependencies
dart analyze

if [ $? -eq 0 ]; then
  echo "Clean build validation successful."
else
  echo "Clean build validation failed."
  exit 1
fi
