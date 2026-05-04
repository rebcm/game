#!/bin/bash

# Run CI/CD pipeline locally
flutter drive --driver=test/integration_tests/integration_test_driver/integration_test_driver.dart --target=test/integration_tests/smoke_test/smoke_test.dart
