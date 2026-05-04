#!/bin/bash

# Update package list
sudo apt update

# Install necessary dependencies
sudo apt install -y curl git unzip xz-utils zip libgl1-mesa-dev

# Install Flutter
curl -L https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.3.10-stable.tar.xz -o flutter.tar.xz
tar -xf flutter.tar.xz -C /opt/
rm flutter.tar.xz
export PATH="$PATH:/opt/flutter/bin"
echo 'export PATH="$PATH:/opt/flutter/bin"' >> ~/.bashrc

# Verify Flutter installation
flutter --version

# Install Dart
sudo apt install -y dart

# Verify Dart installation
dart --version

# Install Android SDK
sudo apt install -y openjdk-11-jdk
curl -L https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip -o android-sdk.zip
unzip android-sdk.zip -d android-sdk
rm android-sdk.zip
export ANDROID_HOME=$PWD/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools
echo 'export ANDROID_HOME=$PWD/android-sdk' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools' >> ~/.bashrc
yes | sdkmanager --licenses
sdkmanager "platform-tools" "platforms;android-31" "build-tools;31.0.0"

# Verify Android SDK installation
adb --version

