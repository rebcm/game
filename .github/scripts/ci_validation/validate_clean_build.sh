#!/bin/bash

echo "Validating clean build..."

flutter clean
flutter pub get

echo "Running dart analyze..."
dart analyze

if [ $? -ne 0 ]; then
  echo "dart analyze failed with errors."
  exit 1
else
  echo "Clean build and static analysis successful."
fi
