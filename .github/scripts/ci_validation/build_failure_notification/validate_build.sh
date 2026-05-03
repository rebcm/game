#!/bin/bash

# Run the build command
if ! flutter build apk; then
  # If build fails, send notification
  .github/scripts/ci_validation/build_failure_notification/send_notification.sh
  exit 1
fi
