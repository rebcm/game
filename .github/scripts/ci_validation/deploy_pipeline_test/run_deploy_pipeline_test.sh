#!/bin/bash

# Validação de Build do Flutter Web
flutter config --enable-web
flutter clean
flutter pub get
flutter build web

# Verificação de Conectividade com Cloudflare
# Simulação de deploy para verificar conectividade
# Este passo deve ser adaptado de acordo com o processo real de deploy
curl -X GET https://api.cloudflare.com/client/v4/user/tokens/verify \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  -H "Content-Type: application/json"

# Teste de Rollback em Caso de Falha no Deploy
# Simulação de falha no deploy e verificação de rollback
# Este passo deve ser adaptado de acordo com o processo real de deploy e rollback
if ! flutter build web; then
  echo "Deploy falhou, realizando rollback..."
  # Comando para realizar rollback
  # git checkout HEAD~1 # Exemplo, não usar git commands
  echo "Rollback realizado com sucesso."
fi
