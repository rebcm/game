#!/bin/bash

# Configura o ambiente para build de iOS
echo "Configurando o ambiente para build de iOS..."

# Instala dependências necessárias
flutter pub get

# Limpa builds anteriores
flutter clean

# Constrói o IPA
echo "Construindo o IPA..."
flutter build ios --release --no-codesign

# Arquiva o IPA
echo "Arquivando o IPA..."
mkdir -p build/ios/ipa
xcodebuild -exportArchive -archivePath build/ios/Release-iphoneos/Runner.xcarchive -exportPath build/ios/ipa -exportOptionsPlist .github/scripts/ExportOptions.plist

# Verifica se o IPA foi gerado
if [ -f build/ios/ipa/Runner.ipa ]; then
  echo "IPA gerado com sucesso!"
else
  echo "Falha ao gerar o IPA."
  exit 1
fi
