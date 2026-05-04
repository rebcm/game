#!/bin/bash

# Atualiza a documentação da API no diretório .github/docs/api_endpoints_mapping

# Lista de arquivos markdown na pasta api_endpoints_mapping
for file in .github/docs/api_endpoints_mapping/*.md; do
  # Verifica se o arquivo foi modificado recentemente
  if [ "$file" -nt .github/docs/api_endpoints_mapping/timestamp ]; then
    echo "Atualizando timestamp para $file"
    touch .github/docs/api_endpoints_mapping/timestamp
  fi
done

echo "Documentação da API atualizada com sucesso!"
