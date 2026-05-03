#!/bin/bash

# Validate if the content has been approved by the Game Designer or Technical Lead
approved=$(grep -c "APROVADO" docs/dicas_construcao/conteudo_dicas.md)

if [ $approved -eq 0 ]; then
  echo "Content has not been approved"
  exit 1
fi
