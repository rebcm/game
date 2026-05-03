#!/bin/bash

if ! grep -q "Comece construindo uma base sólida." game/docs/dicas/conteudo_dicas.dart; then
  echo "Conteúdo de dicas não encontrado"
  exit 1
fi
