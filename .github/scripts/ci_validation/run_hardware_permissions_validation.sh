#!/bin/bash

# Validar permissões de hardware
if ! grep -q "android.permission.RECORD_AUDIO" android/app/src/main/AndroidManifest.xml; then
  echo "Permissão RECORD_AUDIO não encontrada no AndroidManifest.xml"
  exit 1
fi

if ! grep -q "NSMicrophoneUsageDescription" ios/Runner/Info.plist; then
  echo "Descrição de uso do microfone não encontrada no Info.plist"
  exit 1
fi
