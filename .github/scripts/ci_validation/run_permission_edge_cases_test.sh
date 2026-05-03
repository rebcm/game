#!/bin/bash

# Test if NSMicrophoneUsageDescription is correctly set
if ! grep -q "NSMicrophoneUsageDescription" "$INFO_PLIST_PATH"; then
  echo "NSMicrophoneUsageDescription not found in Info.plist"
  exit 1
fi

USAGE_DESCRIPTION=$(plutil -p "$INFO_PLIST_PATH" | grep -A1 NSMicrophoneUsageDescription | tail -n 1 | sed 's/"//g')
if [ -z "$USAGE_DESCRIPTION" ] || [ "${USAGE_DESCRIPTION}" = "O aplicativo precisa acessar o microfone para funcionar corretamente." ]; then
  echo "NSMicrophoneUsageDescription is correctly set"
else
  echo "NSMicrophoneUsageDescription is not correctly set"
  exit 1
fi
