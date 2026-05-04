# Hardware Baseline Documentation

## Overview
This document outlines the reference hardware used for benchmarking the game's performance.

## Devices
The following devices are used as the baseline for Android and iOS testing:

### Android Devices
- Google Pixel 6
- Samsung Galaxy S21

### iOS Devices
- Apple iPhone 13
- Apple iPad Pro (2021)

## OS Versions
- Android 11 and above
- iOS 15 and above

## Data Collection
To collect FPS data, run the following command:
flutter drive --driver=test/integration_tests/performance_test/performance_test_driver.dart --target=test/integration_tests/performance_test/performance_test.dart --profile --trace-systrace --target-platform android

For iOS, adjust the target platform accordingly.

## Script to List Devices
Use the `list_devices.sh` script to list connected devices.

{"pt-BR": "Tradução para pt-BR"}
