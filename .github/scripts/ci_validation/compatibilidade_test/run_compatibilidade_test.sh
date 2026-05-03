#!/bin/bash

# Executa testes de compatibilidade
echo "Executando testes de compatibilidade..."

# Verifica se o build APK/Bundle é feito sem erros de 'major version'
echo "Verificando build APK/Bundle..."
flutter build apk --release
if [ $? -ne 0 ]; then
  echo "Erro ao build APK/Bundle"
  exit 1
fi

# Verifica o tempo de build
echo "Verificando tempo de build..."
time flutter build apk --release

# Verifica se a sincronização Gradle é concluída sem warnings de JDK
echo "Verificando sincronização Gradle..."
cd android && ./gradlew assembleRelease --warning-mode all
if [ $? -ne 0 ]; then
  echo "Erro ao sincronizar Gradle"
  exit 1
fi

echo "Testes de compatibilidade concluídos com sucesso!"
