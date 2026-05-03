#!/bin/bash

# Clean the project
flutter clean

# Get dependencies
flutter pub get

# Analyze the project for errors
dart analyze

# Check if there are any errors
if [ $? -ne 0 ]; then
  echo "Errors found during static analysis"
  exit 1
else
  echo "Clean build and static analysis successful"
fi
