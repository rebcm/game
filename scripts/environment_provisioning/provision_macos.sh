#!/bin/bash

# Install necessary dependencies
brew install git unzip xz

# Install Flutter
curl -L https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_3.3.10-stable.zip -o flutter.zip
unzip flutter.zip -d /opt/
rm flutter.zip
export PATH="$PATH:/opt/flutter/bin"
echo 'export PATH="$PATH:/opt/flutter/bin"' >> ~/.bash_profile

# Verify Flutter installation
flutter --version

# Install Dart
brew tap dart-lang/dart
brew install dart

# Verify Dart installation
dart --version

# Install Xcode
xcode-select --install

