#!/bin/bash

INFO_PLIST_PATH="ios/Runner/Info.plist"
NS_CAMERA_USAGE_DESCRIPTION=$(/usr/libexec/PlistBuddy -c "Print :NSCameraUsageDescription" "$INFO_PLIST_PATH")
NS_PHOTO_LIBRARY_USAGE_DESCRIPTION=$(/usr/libexec/PlistBuddy -c "Print :NSPhotoLibraryUsageDescription" "$INFO_PLIST_PATH")

if ! grep -q "para compartilhar criacoes" <<< "$NS_CAMERA_USAGE_DESCRIPTION"; then
  echo "NSCameraUsageDescription não contém a justificativa correta"
  exit 1
fi

if ! grep -q "para compartilhar criacoes" <<< "$NS_PHOTO_LIBRARY_USAGE_DESCRIPTION"; then
  echo "NSPhotoLibraryUsageDescription não contém a justificativa correta"
  exit 1
fi

echo "Descrições de uso da câmera e biblioteca de fotos validadas com sucesso"
