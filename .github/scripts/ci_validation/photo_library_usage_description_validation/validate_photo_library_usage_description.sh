#!/bin/bash

description=$(grep -A1 NSPhotoLibraryUsageDescription ios/Runner/Info.plist | tail -n1 | sed -E 's/.*>(.*)<.*/\1/')
if [ "$description" != "A biblioteca de fotos é usada para salvar e compartilhar suas criações." ]; then
  echo "Descrição de uso da biblioteca de fotos inválida."
  exit 1
fi
