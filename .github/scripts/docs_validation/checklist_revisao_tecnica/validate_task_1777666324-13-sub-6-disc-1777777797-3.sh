#!/bin/bash

# Validar o conteúdo do arquivo revisao_ortografica_task_1777666324-13-sub-6-disc-1777777797-3.md

CONTENT_FILE="./docs/revisao_ortografica_task_1777666324-13-sub-6-disc-1777777797-3.md"

if [ ! -f "$CONTENT_FILE" ]; then
  echo "Arquivo $CONTENT_FILE não encontrado."
  exit 1
fi

# Verificar se o conteúdo está vazio
if [ ! -s "$CONTENT_FILE" ]; then
  echo "Conteúdo do arquivo $CONTENT_FILE está vazio."
  exit 1
fi

# Verificar a ortografia
aspell --lang=pt_BR --mode=markdown check "$CONTENT_FILE"

# Verificar a presença de critérios de aceitação
if ! grep -q "Critérios de Aceitação" "$CONTENT_FILE"; then
  echo "Critérios de Aceitação não encontrados no arquivo $CONTENT_FILE."
  exit 1
fi

echo "Validação do conteúdo concluída com sucesso."
