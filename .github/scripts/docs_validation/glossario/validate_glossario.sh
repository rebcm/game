#!/bin/bash

if [ ! -f .github/docs/glossario.md ]; then
  echo "Glossário não encontrado"
  exit 1
fi

if [ ! -s .github/docs/glossario.md ]; then
  echo "Glossário vazio"
  exit 1
fi
