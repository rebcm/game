#!/bin/bash

# Executar flutter doctor e capturar a saída
output=$(flutter doctor)

# Extrair erros de dependências ausentes
errors=$(echo "$output" | grep -i "error" || true)

# Documentar erros no arquivo de critérios de aceitação
doc_file=.github/docs/passdriver_flutter_doctor/criterios_aceitacao.md

# Verificar se o arquivo de documentação existe
if [ -f "$doc_file" ]; then
  # Substituir a seção de erros encontrados
  sed -i '/### Erros Encontrados/,/.*/c ### Erros Encontrados\n'"$errors"'' "$doc_file"
else
  echo "Arquivo de documentação não encontrado: $doc_file"
  exit 1
fi
