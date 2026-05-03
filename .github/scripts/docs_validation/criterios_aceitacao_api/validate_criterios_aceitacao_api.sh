#!/bin/bash

# Verifica se a documentação da API está de acordo com os critérios de aceitação
# definidos para os endpoints obrigatórios, tipos de dados e exemplos de payloads.

# Diretório da documentação da API
DOCS_DIR="./lib/docs/api"

# Verifica se o diretório da documentação existe
if [ ! -d "$DOCS_DIR" ]; then
  echo "Diretório de documentação da API não encontrado."
  exit 1
fi

# Lista de endpoints obrigatórios
ENDPOINTS_OBRIGATORIOS=("GET /blocos" "POST /blocos" "GET /blocos/{id}" "PUT /blocos/{id}" "DELETE /blocos/{id}")

# Verifica se os endpoints obrigatórios estão documentados
for endpoint in "${ENDPOINTS_OBRIGATORIOS[@]}"; do
  if ! grep -q "$endpoint" "$DOCS_DIR/endpoints.md"; then
    echo "Endpoint $endpoint não está documentado."
    exit 1
  fi
done

# Verifica se os tipos de dados estão documentados
if ! grep -q "Tipos de Dados" "$DOCS_DIR/tipos_de_dados.md"; then
  echo "Tipos de dados não estão documentados."
  exit 1
fi

# Verifica se os exemplos de payloads estão documentados
if ! grep -q "Exemplos de Payloads" "$DOCS_DIR/exemplos_de_payloads.md"; then
  echo "Exemplos de payloads não estão documentados."
  exit 1
fi

echo "Critérios de aceitação da API validados com sucesso."
