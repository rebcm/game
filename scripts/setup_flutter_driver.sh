#!/bin/bash

# Setup Flutter Driver
echo "Setting up Flutter Driver..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "Flutter not found. Please install Flutter and try again."
    exit 1
fi

# Run Flutter pub get to fetch dependencies
flutter pub get

# Check if flutter_driver is installed
if ! flutter pub deps --no-dev | grep -q flutter_driver; then
    echo "flutter_driver not found in dependencies. Adding it..."

    # Add flutter_driver to pubspec.yaml if not present
    sed -i '/dependencies:/a \  flutter_driver:\n    sdk: flutter' pubspec.yaml
    flutter pub get
fi

echo "Flutter Driver setup complete."
