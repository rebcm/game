#!/bin/bash

# Validates the documentation checklist

# Check if the documentation checklist file exists
if [ ! -f ./docs/checklist_documentacao.md ]; then
  echo "Documentation checklist file not found."
  exit 1
fi

# Define the required topics
required_topics=("Versão do Flutter" "Dependências" "Variáveis de Ambiente" "Comandos de Build")

# Check if all required topics are present in the checklist
for topic in "${required_topics[@]}"; do
  if ! grep -q "$topic" ./docs/checklist_documentacao.md; then
    echo "Topic '$topic' not found in the documentation checklist."
    exit 1
  fi
done

echo "Documentation checklist is valid."
