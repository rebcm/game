#!/bin/bash

# Run flutter build command
flutter build apk

# Check if build was successful
if [ $? -ne 0 ]; then
  # Trigger send_notification.sh if build fails
  .github/scripts/ci_validation/build_failure_notification/send_notification.sh
fi
