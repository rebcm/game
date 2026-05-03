#!/bin/bash

INFO_PLIST="ios/Runner/Info.plist"
PHOTO_LIBRARY_USAGE_DESCRIPTION=$(/usr/libexec/PlistBuddy -c "Print :NSPhotoLibraryUsageDescription" "$INFO_PLIST")

if [ -z "$PHOTO_LIBRARY_USAGE_DESCRIPTION" ] || ! echo "$PHOTO_LIBRARY_USAGE_DESCRIPTION" | grep -q "biblioteca de fotos é usada para salvar"; then
    echo "NSPhotoLibraryUsageDescription não está configurada corretamente."
    exit 1
fi
