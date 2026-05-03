#!/bin/bash

# Clean and rebuild the project to ensure no compilation errors
echo "Running flutter clean..."
flutter clean

echo "Running flutter pub get..."
flutter pub get

echo "Running dart analyze..."
dart analyze

if [ $? -eq 0 ]; then
  echo "Clean build and static analysis successful."
else
  echo "Clean build or static analysis failed."
  exit 1
fi
