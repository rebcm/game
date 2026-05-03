#!/bin/bash

INFO_PLIST="ios/Runner/Info.plist"
MICROPHONE_USAGE_DESCRIPTION=$(/usr/libexec/PlistBuddy -c "Print :NSMicrophoneUsageDescription" "$INFO_PLIST")

if [ -z "$MICROPHONE_USAGE_DESCRIPTION" ] || [ ${#MICROPHONE_USAGE_DESCRIPTION} -lt 10 ]; then
    echo "NSMicrophoneUsageDescription deve ser clara e ter pelo menos 10 caracteres."
    exit 1
fi
