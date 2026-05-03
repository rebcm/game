#!/bin/bash

# Configura o ambiente para build de iOS
echo "Configurando ambiente para build de iOS..."

# Verifica se as variáveis necessárias estão definidas
if [ -z "$APPLE_CERTIFICATE" ] || [ -z "$APPLE_PROVISIONING_PROFILE" ]; then
  echo "Variáveis de certificado e perfil de provisionamento não definidas."
  exit 1
fi

# Decodifica e configura o certificado e o perfil de provisionamento
echo "Configurando certificado e perfil de provisionamento..."
echo "$APPLE_CERTIFICATE" | base64 --decode > /tmp/certificate.p12
echo "$APPLE_PROVISIONING_PROFILE" | base64 --decode > /tmp/provisioning_profile.mobileprovision

# Configura o keychain para o build
echo "Configurando keychain..."
security create-keychain -p "" build.keychain
security default-keychain -s build.keychain
security unlock-keychain -p "" build.keychain
security import /tmp/certificate.p12 -k build.keychain -P "" -T /usr/bin/codesign
security set-key-partition-list -S apple-tool:,apple: -s -k "" build.keychain

# Copia o perfil de provisionamento para o local correto
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp /tmp/provisioning_profile.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/

# Realiza o build do IPA
echo "Realizando build do IPA..."
flutter build ipa --release --export-options-plist=.github/scripts/ExportOptions.plist

# Upload do artefato
echo "Fazendo upload do artefato..."
mkdir -p build/artifacts
cp build/ios/ipa/*.ipa build/artifacts/
