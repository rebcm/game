#!/bin/bash

# Set the devices and OS versions
android_devices=("Google Pixel 4" "Samsung Galaxy S22" "OnePlus 9 Pro")
android_os="Android 12"
ios_devices=("Apple iPhone 13" "Apple iPhone 12" "Apple iPad Pro")
ios_os="iOS 16"

# Set the game version
game_version="1.0.0+1"

# Set the test settings
test_settings=("low" "medium" "high")

# Run the tests and collect the data
for device in "${android_devices[@]}"; do
  for setting in "${test_settings[@]}"; do
    # Run the test and collect the FPS data
    fps_data=$(run_test "$device" "$android_os" "$game_version" "$setting")
    echo "Device: $device, OS: $android_os, Game Version: $game_version, Setting: $setting, FPS: $fps_data"
  done
done

for device in "${ios_devices[@]}"; do
  for setting in "${test_settings[@]}"; do
    # Run the test and collect the FPS data
    fps_data=$(run_test "$device" "$ios_os" "$game_version" "$setting")
    echo "Device: $device, OS: $ios_os, Game Version: $game_version, Setting: $setting, FPS: $fps_data"
  done
done
