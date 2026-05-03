#!/bin/bash

# Script to run memory leak test for the Flutter game

# Navigate to the project root
cd /home/user/game

# Run the Flutter driver test for memory leak
flutter drive --target=test_driver/app.dart --driver=test_driver/memory_leak_test.dart --profile --verbose

# Collect and analyze the memory usage data
