#!/bin/bash

INFO_PLIST_FILE="ios/Runner/Info.plist"

if ! grep -q "NSMicrophoneUsageDescription" "$INFO_PLIST_FILE"; then
  echo "Erro: NSMicrophoneUsageDescription não encontrado no Info.plist"
  exit 1
fi

MICROPHONE_USAGE_DESCRIPTION=$(grep -A1 "NSMicrophoneUsageDescription" "$INFO_PLIST_FILE" | tail -n1 | sed 's/.*<string>\(.*\)<\/string>.*/\1/')
if [ "$MICROPHONE_USAGE_DESCRIPTION" != "Este aplicativo precisa acessar o microfone para gravar áudio." ]; then
  echo "Erro: Texto de justificativa para NSMicrophoneUsageDescription incorreto"
  exit 1
fi

echo "NSMicrophoneUsageDescription validado com sucesso"
