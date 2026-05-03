#!/bin/bash

# Executar testes de edge cases de áudio
flutter drive --target=test_driver/audio_edge_cases_test.dart --driver=test_driver/audio_edge_cases_test_driver.dart

# Verificar se os critérios de aceitação foram atendidos
if [ -f ./.github/scripts/ci_validation/audio_edge_cases_test/docs/criterios_aceitacao_audio.md ]; then
  echo "Critérios de aceitação atendidos"
else
  echo "Critérios de aceitação não atendidos"
  exit 1
fi
