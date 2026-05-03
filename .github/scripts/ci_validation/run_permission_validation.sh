#!/bin/bash

# Validar se as permissões mínimas estão sendo respeitadas
# no pipeline de CI/CD

# Diretório das ações do pipeline
PIPELINE_ACTIONS_DIR=".github/workflows"

# Verificar se o diretório existe
if [ ! -d "$PIPELINE_ACTIONS_DIR" ]; then
  echo "Diretório de ações do pipeline não encontrado."
  exit 1
fi

# Percorrer os arquivos de ação do pipeline
for file in "$PIPELINE_ACTIONS_DIR"/*.yml; do
  # Extrair as permissões necessárias para cada ação
  permissions=$(yq e '.jobs[] | .steps[] | .run' "$file" | grep -o 'permission:.*')
  
  # Verificar se as permissões estão de acordo com a matriz
  while IFS= read -r permission; do
    # Implementar lógica para verificar se a permissão está na matriz
    # e se é a mínima necessária
    echo "Validando permissão: $permission"
  done <<< "$permissions"
done

