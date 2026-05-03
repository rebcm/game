#!/bin/bash

# Run flutter build command and capture exit status
flutter build apk
BUILD_STATUS=$?

# If build fails, send notification
if [ $BUILD_STATUS -ne 0 ]; then
  .github/scripts/ci_validation/build_failure_notification/send_notification.sh
  exit $BUILD_STATUS
fi
