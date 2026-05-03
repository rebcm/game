#!/bin/bash

INFO_PLIST="ios/Runner/Info.plist"
PHOTO_LIBRARY_USAGE_DESCRIPTION=$(plutil -extract NSPhotoLibraryUsageDescription raw "$INFO_PLIST")

if [ "$PHOTO_LIBRARY_USAGE_DESCRIPTION" != "A biblioteca de fotos é usada para salvar suas criações voxel." ]; then
    echo "Erro: NSPhotoLibraryUsageDescription não atende aos critérios de aceitação."
    exit 1
fi
