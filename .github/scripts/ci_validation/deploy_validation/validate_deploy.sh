#!/bin/bash

# Validação de build do Flutter Web
flutter config --enable-web
flutter clean
flutter pub get
flutter build web

# Verificação de conectividade com Cloudflare
curl -s -o /dev/null -w "%{http_code}" https://example.cloudflare.com | grep -q "200"
if [ $? -ne 0 ]; then
  echo "Falha na conexão com Cloudflare"
  exit 1
fi

# Teste de rollback em caso de falha no deploy
# Simulação de falha no deploy
exit 1
