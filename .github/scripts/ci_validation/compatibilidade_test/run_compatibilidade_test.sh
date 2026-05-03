#!/bin/bash

# Executa o teste de compatibilidade
echo "Executando teste de compatibilidade..."

# Verifica se o build do APK/Bundle é concluído sem erros de 'major version'
echo "Verificando build do APK/Bundle..."
flutter build apk --release > build_log.txt 2>&1
if grep -q "major version" build_log.txt; then
  echo "Erro: Build do APK/Bundle falhou devido a erro de 'major version'"
  exit 1
fi

# Verifica se o tempo de build é estável
echo "Verificando tempo de build..."
build_time=$(cat build_log.txt | grep "Built build" | awk '{print $NF}')
echo "Tempo de build: $build_time"

# Verifica se a sincronização do Gradle é concluída sem warnings de JDK
echo "Verificando sincronização do Gradle..."
gradle_sync_log=$(./gradlew :app:assembleRelease --dry-run 2>&1)
if echo "$gradle_sync_log" | grep -q "WARNING.*JDK"; then
  echo "Erro: Sincronização do Gradle falhou devido a warning de JDK"
  exit 1
fi

echo "Teste de compatibilidade concluído com sucesso!"
