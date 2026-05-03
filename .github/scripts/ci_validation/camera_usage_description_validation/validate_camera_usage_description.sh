#!/bin/bash

INFO_PLIST="ios/Runner/Info.plist"
if grep -q "NSCameraUsageDescription" "$INFO_PLIST"; then
  DESCRIPTION=$(grep -A1 "NSCameraUsageDescription" "$INFO_PLIST" | tail -n1 | sed -E 's/.*>(.*)<.*/\1/')
  if [ "$DESCRIPTION" != "O jogo Rebeca utiliza a câmera para permitir que você importe imagens e as utilize como inspiração ou referência para suas criações." ]; then
    echo "Erro: A descrição de uso da câmera não está correta."
    exit 1
  fi
else
  echo "Erro: NSCameraUsageDescription não encontrado no Info.plist"
  exit 1
fi
