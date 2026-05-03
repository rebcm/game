#!/bin/bash

# Executa testes de compatibilidade da engine de física
flutter test test/physics_engine_compatibility_test.dart

# Verifica se os testes passaram
if [ $? -eq 0 ]; then
  echo "Testes de compatibilidade da engine de física passaram com sucesso."
else
  echo "Falha nos testes de compatibilidade da engine de física."
  exit 1
fi
