#!/bin/bash

# Atualiza a documentação do processo de distribuição
# com as informações mais recentes do pipeline.

# Verifica se o arquivo de documentação existe
if [ ! -f .github/docs/distribution_process_documentation/distribution_process.md ]; then
  echo "Arquivo de documentação não encontrado."
  exit 1
fi

# Atualiza o arquivo de documentação
# com as informações mais recentes do pipeline
echo "Atualizando documentação..."

