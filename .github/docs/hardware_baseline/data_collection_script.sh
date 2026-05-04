#!/bin/bash

# List available devices
flutter devices

# Run the FPS benchmark on each device
# For Android: flutter run --profile --target lib/main.dart
# For iOS: flutter run --profile --target lib/main.dart

# Collect FPS data
# fps_data=$(flutter drive --profile --target test/performance_test/fps_test.dart --driver test/performance_test/fps_test_driver.dart)

# Output the FPS data to a file
# echo "$fps_data" > fps_data.txt

# List the devices and OS versions that will serve as the baseline
echo "List of devices and OS versions for baseline FPS collection:"
flutter devices --machine | jq '.[] | {device_id, name, osVersion}'
