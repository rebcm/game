#!/bin/bash

flutter pub get
flutter test --platform chrome test/integration_test/contract_test.dart
