#!/bin/bash

OUTPUT_FILE=$(find . -name 'bloco_metadata.json')

if [ -z "$OUTPUT_FILE" ]; then
  echo "Arquivo de metadados não encontrado."
  exit 1
fi

jq -e '.id != null and .nome != null and .descricao != null and .categoria != null' $OUTPUT_FILE > /dev/null
if [ $? -ne 0 ]; then
  echo "Schema de saída inválido."
  exit 1
fi

echo "Schema de saída validado com sucesso."
