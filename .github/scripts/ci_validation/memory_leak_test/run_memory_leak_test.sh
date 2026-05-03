#!/bin/bash

# Script to run memory leak tests for the Flutter application

# Navigate to the project root
cd /home/user/game

# Run the memory leak test using Flutter Driver
flutter drive --target=test/integration_tests/memory_leak_test/memory_leak_test.dart --driver=test/integration_tests/memory_leak_test/memory_leak_test_driver.dart

