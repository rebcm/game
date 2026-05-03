#!/bin/bash

INFO_PLIST="ios/Runner/Info.plist"
CAMERA_USAGE_DESCRIPTION=$(/usr/libexec/PlistBuddy -c "Print :NSCameraUsageDescription" "$INFO_PLIST")

if [ -z "$CAMERA_USAGE_DESCRIPTION" ] || [ ${#CAMERA_USAGE_DESCRIPTION} -lt 10 ]; then
    echo "NSCameraUsageDescription deve ser clara e ter pelo menos 10 caracteres."
    exit 1
fi
