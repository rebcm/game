#!/bin/bash

INFO_PLIST="ios/Runner/Info.plist"
if grep -q "NSPhotoLibraryUsageDescription" "$INFO_PLIST"; then
  DESCRIPTION=$(grep -A1 "NSPhotoLibraryUsageDescription" "$INFO_PLIST" | tail -n1 | sed -E 's/.*>(.*)<.*/\1/')
  if [ "$DESCRIPTION" != "O jogo Rebeca acessa sua biblioteca de fotos para permitir que você importe imagens e as utilize em suas criações." ]; then
    echo "Erro: A descrição de uso da biblioteca de fotos não está correta."
    exit 1
  fi
else
  echo "Erro: NSPhotoLibraryUsageDescription não encontrado no Info.plist"
  exit 1
fi
