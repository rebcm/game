#!/bin/bash

# Valida a presença e o conteúdo da chave NSMicrophoneUsageDescription no Info.plist

INFO_PLIST_PATH="ios/Runner/Info.plist"

if ! grep -q "NSMicrophoneUsageDescription" "$INFO_PLIST_PATH"; then
  echo "Erro: NSMicrophoneUsageDescription não encontrado no Info.plist"
  exit 1
fi

DESCRIPTION=$(plutil -p "$INFO_PLIST_PATH" | grep -A1 NSMicrophoneUsageDescription | tail -n 1 | xargs)
EXPECTED_DESCRIPTION="O aplicativo precisa acessar o microfone para gravar áudio."

if [ "$DESCRIPTION" != "$EXPECTED_DESCRIPTION" ]; then
  echo "Erro: Descrição da permissão de microfone incorreta. Esperado: '$EXPECTED_DESCRIPTION', Encontrado: '$DESCRIPTION'"
  exit 1
fi

echo "Validação da permissão de microfone bem-sucedida."
