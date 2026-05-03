#!/bin/bash

INFO_PLIST="ios/Runner/Info.plist"
CAMERA_USAGE_DESCRIPTION=$(/usr/libexec/PlistBuddy -c "Print :NSCameraUsageDescription" "$INFO_PLIST")

if [ -z "$CAMERA_USAGE_DESCRIPTION" ] || ! echo "$CAMERA_USAGE_DESCRIPTION" | grep -q "câmera é usada para tirar fotos"; then
    echo "NSCameraUsageDescription não está configurada corretamente."
    exit 1
fi
