#!/bin/bash

# Define the target reduction percentage
TARGET_REDUCTION_PERCENTAGE=20

# Calculate the current APK size
CURRENT_APK_SIZE=$(stat -c%s "build/app/outputs/flutter-apk/app-release.apk")

# Define the target APK size
TARGET_APK_SIZE=$((CURRENT_APK_SIZE - (CURRENT_APK_SIZE * TARGET_REDUCTION_PERCENTAGE / 100)))

# Save the KPI to a file
echo "TARGET_APK_SIZE=$TARGET_APK_SIZE" > kpi-report.txt
