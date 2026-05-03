#!/bin/bash

# Validação de estruturas sugeridas para dicas de gameplay
# Verifica se as estruturas sugeridas estão de acordo com as regras do jogo

# Diretório das estruturas sugeridas
DIRETORIO_ESTRUTURAS="docs/estruturas_sugeridas"

# Verifica se o diretório existe
if [ ! -d "$DIRETORIO_ESTRUTURAS" ]; then
  echo "Diretório de estruturas sugeridas não encontrado."
  exit 1
fi

# Loop pelas estruturas sugeridas
for arquivo in "$DIRETORIO_ESTRUTURAS"/*.md; do
  # Verifica se o arquivo é válido de acordo com os critérios de validação
  if ! validate_documentation_criteria.sh "$arquivo"; then
    echo "Estrutura sugerida em $arquivo não atende aos critérios de validação."
    exit 1
  fi
done

echo "Validação de estruturas sugeridas concluída com sucesso."
