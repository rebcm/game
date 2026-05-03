#!/bin/bash

# Run memory leak detection using Flutter Driver
flutter drive --target=test_driver/app.dart --driver=test_driver/memory_leak_test.dart --profile

# Analyze the results
