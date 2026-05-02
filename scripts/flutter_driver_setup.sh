#!/bin/bash

# Setup Flutter Driver
echo "Setting up Flutter Driver..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "Flutter not found. Please install Flutter and try again."
    exit 1
fi

# Check if Dart is installed
if ! command -v dart &> /dev/null; then
    echo "Dart not found. Please install Dart and try again."
    exit 1
fi

# Get Flutter dependencies
echo "Getting Flutter dependencies..."
flutter pub get

echo "Flutter Driver setup complete."
