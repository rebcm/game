#!/bin/bash

# Diretório do projeto
PROJECT_DIR=$(pwd)

# Executar build do APK/Bundle e verificar erros de 'major version'
echo "Executando build do APK/Bundle..."
flutter build apk > build_log.txt 2>&1
if grep -q "major version" build_log.txt; then
  echo "Erro: Build do APK/Bundle apresentou erros de 'major version'."
  exit 1
fi

# Medir tempo de build
echo "Medindo tempo de build..."
BUILD_TIME=$(time (flutter build apk > /dev/null 2>&1) 2>&1 | grep real | awk '{print $2}')
echo "Tempo de build: $BUILD_TIME"

# Verificar sincronização do Gradle
echo "Verificando sincronização do Gradle..."
cd android && ./gradlew --version > gradle_log.txt 2>&1
if grep -q "WARNING" gradle_log.txt | grep -q "JDK"; then
  echo "Erro: Sincronização do Gradle apresentou warnings relacionados ao JDK."
  exit 1
fi

echo "Teste de compatibilidade concluído com sucesso."
exit 0
