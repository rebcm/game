#!/bin/bash

# Configura o ambiente para build de iOS
echo "Configurando o ambiente para build de iOS..."

# Verifica se as variáveis de ambiente necessárias estão configuradas
if [ -z "$APPLE_CERTIFICATE" ] || [ -z "$APPLE_PROVISIONING_PROFILE" ]; then
  echo "Variáveis de ambiente não configuradas corretamente."
  exit 1
fi

# Instala as dependências necessárias
flutter pub get

# Limpa o projeto Flutter
flutter clean

# Compila o projeto Flutter para iOS
flutter build ios --release --no-codesign

echo "Build de iOS concluído com sucesso."
