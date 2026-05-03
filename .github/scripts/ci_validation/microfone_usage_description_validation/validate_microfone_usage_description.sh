#!/bin/bash

PLIST_FILE="ios/Runner/Info.plist"
if ! grep -q "NSMicrophoneUsageDescription" "$PLIST_FILE"; then
  echo "NSMicrophoneUsageDescription não encontrado no Info.plist"
  exit 1
fi

DESCRIPTION=$(grep -A1 "NSMicrophoneUsageDescription" "$PLIST_FILE" | tail -n1 | sed -E 's/.*<string>(.*)<\/string>.*/\1/')
if [ -z "$DESCRIPTION" ]; then
  echo "A descrição para NSMicrophoneUsageDescription está vazia"
  exit 1
fi

echo "NSMicrophoneUsageDescription está configurado corretamente: $DESCRIPTION"

MANIFEST_FILE="android/app/src/main/AndroidManifest.xml"
if ! grep -q "RECORD_AUDIO" "$MANIFEST_FILE"; then
  echo "Permissão RECORD_AUDIO não encontrada no AndroidManifest.xml"
  exit 1
fi

echo "Permissão RECORD_AUDIO está declarada no AndroidManifest.xml"
