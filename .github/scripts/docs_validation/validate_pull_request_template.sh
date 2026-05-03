#!/bin/bash

TEMPLATE_FILE=".github/pull_request_template/pull_request_template.md"

if [ ! -f "$TEMPLATE_FILE" ]; then
  echo "Erro: Template de PR não encontrado."
  exit 1
fi

CHECKLIST_ITEMS=("A descrição da PR está clara e concisa" "As mudanças estão de acordo com o solicitado na issue/task" "A documentação foi atualizada (se aplicável)" "O código segue as diretrizes de estilo do projeto" "Testes foram adicionados ou atualizados (se aplicável)" "A tradução para PT-BR está correta (se aplicável)")

for item in "${CHECKLIST_ITEMS[@]}"; do
  if ! grep -q "$item" "$TEMPLATE_FILE"; then
    echo "Erro: Item de checklist '$item' não encontrado no template de PR."
    exit 1
  fi
done

echo "Template de PR validado com sucesso."
exit 0
