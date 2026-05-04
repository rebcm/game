#!/bin/bash

# Mapeia segredos utilizados no código para listagem no wrangler.toml

echo "Mapeando segredos..."

# Buscar por usos de dotenv ou variáveis de ambiente no código Dart
grep -r 'dotenv.get' lib/ || echo "Nenhum uso de dotenv encontrado."

# Listar variáveis de ambiente utilizadas
grep -r 'Platform.environment' lib/ || echo "Nenhuma variável de ambiente encontrada."

echo "Mapeamento concluído. Verifique .github/docs/api_key_mapping/api_key_mapping.md para detalhes."

