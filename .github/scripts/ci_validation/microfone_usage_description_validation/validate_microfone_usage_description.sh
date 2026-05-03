#!/bin/bash

INFO_PLIST="ios/Runner/Info.plist"
MICROPHONE_USAGE_DESCRIPTION=$(/usr/libexec/PlistBuddy -c "Print :NSMicrophoneUsageDescription" "$INFO_PLIST")

if [ -z "$MICROPHONE_USAGE_DESCRIPTION" ] || ! echo "$MICROPHONE_USAGE_DESCRIPTION" | grep -q "microfone é necessário para gravar áudios"; then
    echo "NSMicrophoneUsageDescription não está configurada corretamente."
    exit 1
fi
