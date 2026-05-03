#!/bin/bash

# Capture the exit status of the build command
BUILD_STATUS=$?

# Check if the build failed
if [ $BUILD_STATUS -ne 0 ]; then
  echo "Build failed with status $BUILD_STATUS"
  # Trigger notification logic here, e.g., calling send_notification.sh
  .github/scripts/ci_validation/build_failure_notification/send_notification.sh
else
  echo "Build successful"
fi
