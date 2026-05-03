#!/bin/bash

# Valida se o arquivo de contexto de dicas contém as resoluções mínimas e dispositivos alvo corretos
if ! grep -q "Resoluções Mínimas" lib/docs/dicas/contexto/resolucoes_contexto.md; then
  echo "Erro: O arquivo resolucoes_contexto.md não contém a seção 'Resoluções Mínimas'"
  exit 1
fi

if ! grep -q "Dispositivos Alvo" lib/docs/dicas/contexto/resolucoes_contexto.md; then
  echo "Erro: O arquivo resolucoes_contexto.md não contém a seção 'Dispositivos Alvo'"
  exit 1
fi
