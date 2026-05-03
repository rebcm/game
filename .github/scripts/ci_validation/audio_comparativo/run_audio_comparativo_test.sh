#!/bin/bash

# Executar teste de comparativo de áudio
flutter drive --driver=test/audio/audio_comparativo_test.dart --target=test/audio/audio_comparativo_test.dart

if [ $? -ne 0 ]; then
  echo "Erro ao executar teste de comparativo de áudio."
  exit 1
fi

echo "Teste de comparativo de áudio executado com sucesso."
