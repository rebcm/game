#!/bin/bash

# Executar testes de compatibilidade de áudio
flutter drive --target=test_driver/audio_test.dart --driver=test_driver/audio_test_driver.dart

# Verificar resultados dos testes
if [ $? -eq 0 ]; then
  echo "Testes de compatibilidade de áudio concluídos com sucesso"
else
  echo "Falha nos testes de compatibilidade de áudio"
  exit 1
fi
