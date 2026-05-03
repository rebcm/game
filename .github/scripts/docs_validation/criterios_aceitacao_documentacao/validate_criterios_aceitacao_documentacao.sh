#!/bin/bash

# Task ID: task-1777666324-13-sub-4-disc-1777777740-2-disc-1777778833-1
# Title: [DOCS] Definição de Critérios de Aceitação (AC)

# Verificar se o arquivo de critérios de aceitação existe
if [ ! -f "./docs/criterios_aceitacao.md" ]; then
  echo "Arquivo de critérios de aceitação não encontrado."
  exit 1
fi

# Verificar se o arquivo de critérios de aceitação está vazio
if [ ! -s "./docs/criterios_aceitacao.md" ]; then
  echo "Arquivo de critérios de aceitação está vazio."
  exit 1
fi

# Verificar se o arquivo de critérios de aceitação contém a definição de sucesso da tarefa
if ! grep -q "O script deve documentar formalmente o que define o sucesso da tarefa" "./docs/criterios_aceitacao.md"; then
  echo "Arquivo de critérios de aceitação não contém a definição de sucesso da tarefa."
  exit 1
fi

echo "Critérios de aceitação validados com sucesso."
exit 0
