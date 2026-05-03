#!/bin/bash

INFO_PLIST="ios/Runner/Info.plist"
PHOTO_LIBRARY_USAGE_DESCRIPTION=$(/usr/libexec/PlistBuddy -c "Print :NSPhotoLibraryUsageDescription" "$INFO_PLIST")

if [ -z "$PHOTO_LIBRARY_USAGE_DESCRIPTION" ] || [ ${#PHOTO_LIBRARY_USAGE_DESCRIPTION} -lt 10 ]; then
    echo "NSPhotoLibraryUsageDescription deve ser clara e ter pelo menos 10 caracteres."
    exit 1
fi
