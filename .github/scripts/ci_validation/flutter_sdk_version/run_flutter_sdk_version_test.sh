#!/bin/bash

# This script validates the Flutter SDK version

# Check if the Flutter SDK version is correct
flutter --version | grep "Flutter 3.0.5"
if [ $? -ne 0 ]; then
  echo "Flutter SDK version is not 3.0.5"
  exit 1
fi
