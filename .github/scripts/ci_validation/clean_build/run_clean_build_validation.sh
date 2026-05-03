#!/bin/bash

echo "Executando clean build validation..."

flutter clean
flutter pub get

echo "Verificando erros de análise estática..."
dart analyze --fatal-infos --fatal-warnings .

if [ $? -eq 0 ]; then
  echo "Clean build e análise estática concluídos com sucesso."
else
  echo "Erro durante clean build ou análise estática."
  exit 1
fi
