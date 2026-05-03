#!/bin/bash

# Run audio compatibility tests on specific Android, iOS, and web platforms
# This script assumes you have the necessary environments set up

# Android
flutter drive --target=test/audio_compatibility/audio_compatibility_test.dart --driver=test_driver/integration_test.dart --flavor=android --device=emulator

# iOS
flutter drive --target=test/audio_compatibility/audio_compatibility_test.dart --driver=test_driver/integration_test.dart --flavor=ios --device=simulator

# Web
flutter drive --target=test/audio_compatibility/audio_compatibility_test.dart --driver=test_driver/integration_test.dart --flavor=web --browser=chrome
