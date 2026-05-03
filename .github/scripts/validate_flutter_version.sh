#!/bin/bash

REQUIRED_FLUTTER_VERSION=$(grep 'flutter: ">=3.0.0"' pubspec.yaml | sed 's/.*flutter: ">=\(.*\)"/\1/')
INSTALLED_FLUTTER_VERSION=$(flutter --version | grep 'Flutter' | sed 's/Flutter \([0-9.]*\).*/\1/')

if [ "$REQUIRED_FLUTTER_VERSION" != "$INSTALLED_FLUTTER_VERSION" ]; then
  echo "Flutter version mismatch. Required: $REQUIRED_FLUTTER_VERSION, Installed: $INSTALLED_FLUTTER_VERSION"
  exit 1
fi

REQUIRED_DART_VERSION=$(grep 'sdk: ">=2.17.0 <3.0.0"' pubspec.yaml | sed 's/.*sdk: ">=\(.*\) <.*/\1/')
INSTALLED_DART_VERSION=$(dart --version | grep 'Dart' | sed 's/Dart SDK version: \([0-9.]*\).*/\1/')

if [ "$REQUIRED_DART_VERSION" != "$INSTALLED_DART_VERSION" ]; then
  echo "Dart version mismatch. Required: $REQUIRED_DART_VERSION, Installed: $INSTALLED_DART_VERSION"
  exit 1
fi
