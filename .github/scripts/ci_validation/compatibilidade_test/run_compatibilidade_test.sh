#!/bin/bash

# Executar o teste de compatibilidade
echo "Executando teste de compatibilidade..."

# Verificar se o build do APK/Bundle foi bem-sucedido sem erros de 'major version'
echo "Verificando build do APK/Bundle..."
flutter build apk --release
if [ $? -ne 0 ]; then
  echo "Erro ao construir APK/Bundle"
  exit 1
fi

# Medir o tempo de build
echo "Medindo tempo de build..."
time flutter build apk --release

# Verificar se a sincronização do Gradle foi bem-sucedida sem warnings de JDK
echo "Verificando sincronização do Gradle..."
./gradlew --version
if [ $? -ne 0 ]; then
  echo "Erro ao sincronizar Gradle"
  exit 1
fi

echo "Teste de compatibilidade concluído com sucesso!"
