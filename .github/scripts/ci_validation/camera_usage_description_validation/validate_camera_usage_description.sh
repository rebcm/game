#!/bin/bash

INFO_PLIST="ios/Runner/Info.plist"
CAMERA_USAGE_DESCRIPTION=$(plutil -extract NSCameraUsageDescription raw "$INFO_PLIST")

if [ "$CAMERA_USAGE_DESCRIPTION" != "A câmera é usada para tirar fotos dos seus mundos voxel criativos." ]; then
    echo "Erro: NSCameraUsageDescription não atende aos critérios de aceitação."
    exit 1
fi
