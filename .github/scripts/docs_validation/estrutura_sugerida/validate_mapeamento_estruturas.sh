#!/bin/bash

# Validar se o arquivo mapeamento_estruturas.md existe
if [ ! -f ./docs/estrutura_sugerida/mapeamento_estruturas.md ]; then
  echo "Erro: O arquivo mapeamento_estruturas.md não existe."
  exit 1
fi

# Validar o conteúdo do arquivo
if ! grep -q "# Mapeamento de Estruturas Sugeridas" ./docs/estrutura_sugerida/mapeamento_estruturas.md; then
  echo "Erro: O arquivo mapeamento_estruturas.md não contém o título esperado."
  exit 1
fi

echo "Validação do mapeamento de estruturas concluída com sucesso."
