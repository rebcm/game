#!/bin/bash

INFO_PLIST="ios/Runner/Info.plist"
if grep -q "NSMicrophoneUsageDescription" "$INFO_PLIST"; then
  DESCRIPTION=$(grep -A1 "NSMicrophoneUsageDescription" "$INFO_PLIST" | tail -n1 | sed -E 's/.*>(.*)<.*/\1/')
  if [ "$DESCRIPTION" != "O jogo Rebeca utiliza o microfone para permitir que você grave áudios personalizados diretamente no jogo, enriquecendo sua experiência criativa." ]; then
    echo "Erro: A descrição de uso do microfone não está correta."
    exit 1
  fi
else
  echo "Erro: NSMicrophoneUsageDescription não encontrado no Info.plist"
  exit 1
fi
