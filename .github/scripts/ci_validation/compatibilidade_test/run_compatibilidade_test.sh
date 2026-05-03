#!/bin/bash

# Executar build APK
echo "Executando build APK..."
flutter build apk --release

# Verificar se houve erros de 'major version'
if grep -q "Major version" build.log; then
  echo "Erro: Build APK com erro de major version"
  exit 1
fi

# Executar build AppBundle
echo "Executando build AppBundle..."
flutter build appbundle --release

# Verificar se houve erros de 'major version'
if grep -q "Major version" build.log; then
  echo "Erro: Build AppBundle com erro de major version"
  exit 1
fi

# Medir tempo de build
echo "Medindo tempo de build..."
time flutter build apk --release

# Verificar sincronização Gradle
echo "Verificando sincronização Gradle..."
gradle sync | grep -q "WARNING" && echo "Warning: Sincronização Gradle com warnings" && exit 1

echo "Teste de compatibilidade concluído com sucesso!"
