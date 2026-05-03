#!/bin/bash

# Configura o ambiente para build do IPA
echo "Configurando o ambiente para build do IPA..."

# Exporta o IPA
xcodebuild -exportArchive -archivePath ./build/ios/Runner.xcarchive -exportPath ./build/ios/ipa -exportOptionsPlist ./.github/scripts/ExportOptions.plist

echo "Build do IPA concluído com sucesso."
