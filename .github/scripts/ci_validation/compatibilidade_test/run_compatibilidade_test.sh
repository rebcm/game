#!/bin/bash

# Executar build do APK/Bundle e verificar erros de 'major version'
echo "Executando build do APK/Bundle..."
flutter build apk --release > build_log.txt 2>&1
if grep -q "major version" build_log.txt; then
  echo "Erro: Build APK/Bundle falhou devido a erro de 'major version'"
  exit 1
fi

# Medir tempo de build
build_time=$(grep "Built build/app/outputs/apk/release/app-release.apk" build_log.txt | tail -1 | awk '{print $NF}')
echo "Tempo de build: $build_time segundos"

# Verificar se o tempo de build está dentro do limite aceitável (ex: 300 segundos)
if (( $(echo "$build_time > 300" | bc -l) )); then
  echo "Erro: Tempo de build excedeu o limite de 300 segundos"
  exit 1
fi

# Executar sincronização Gradle e verificar warnings de JDK
echo "Executando sincronização Gradle..."
./gradlew --warning-mode all assembleRelease > gradle_sync_log.txt 2>&1
if grep -q "warning:" gradle_sync_log.txt | grep -i "jdk"; then
  echo "Erro: Sincronização Gradle apresentou warnings de JDK"
  exit 1
fi

echo "Teste de compatibilidade concluído com sucesso!"
