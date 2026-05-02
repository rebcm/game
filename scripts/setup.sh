#!/bin/bash

# Setup Flutter environment and run tests
flutter pub get
flutter doctor
flutter analyze
flutter test
flutter drive --target=test_driver/integration_test.dart
