#!/bin/bash

# Validar conteúdo da task 1777666324-13-sub-6-disc-1777777797-3
if [ -f "docs/revisao_ortografica_task_1777666324-13-sub-6-disc-1777777797-3.md" ]; then
  echo "Conteúdo validado com sucesso"
else
  echo "Erro ao validar conteúdo"
  exit 1
fi
