#!/bin/bash

# Verifica se o arquivo de critérios de aceitação para UI de Dicas existe
if [ ! -f "./docs/criterios_aceitacao_ui_dicas.md" ]; then
  echo "Erro: Arquivo de critérios de aceitação para UI de Dicas não encontrado."
  exit 1
fi

# Verifica se o arquivo contém as métricas de sucesso e comportamentos esperados
if ! grep -q "Métricas de Sucesso" ./docs/criterios_aceitacao_ui_dicas.md; then
  echo "Erro: Arquivo de critérios de aceitação para UI de Dicas não contém 'Métricas de Sucesso'."
  exit 1
fi

if ! grep -q "Comportamentos Esperados" ./docs/criterios_aceitacao_ui_dicas.md; then
  echo "Erro: Arquivo de critérios de aceitação para UI de Dicas não contém 'Comportamentos Esperados'."
  exit 1
fi

# Verifica se o arquivo contém os gatilhos de exibição e persistência
if ! grep -q "Gatilhos de Exibição" ./docs/criterios_aceitacao_ui_dicas.md; then
  echo "Erro: Arquivo de critérios de aceitação para UI de Dicas não contém 'Gatilhos de Exibição'."
  exit 1
fi

if ! grep -q "Persistência" ./docs/criterios_aceitacao_ui_dicas.md; then
  echo "Erro: Arquivo de critérios de aceitação para UI de Dicas não contém 'Persistência'."
  exit 1
fi

echo "Critérios de aceitação para UI de Dicas validados com sucesso."
exit 0
