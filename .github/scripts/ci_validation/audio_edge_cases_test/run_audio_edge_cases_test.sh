#!/bin/bash

# Executar testes de edge cases para áudio
flutter drive --target=test_driver/audio_integration_test.dart --driver=test_driver/audio_integration_test_driver.dart --test-name="Audio Edge Cases Test"

# Verificar resultados dos testes
if [ $? -eq 0 ]; then
  echo "Testes de áudio edge cases passaram"
else
  echo "Testes de áudio edge cases falharam"
  exit 1
fi

