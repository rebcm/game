#!/bin/bash

# Validar se a documentação contém tópicos obrigatórios
required_topics=("Versão do Flutter" "Dependências" "Variáveis de Ambiente" "Comandos de Build")

for topic in "${required_topics[@]}"; do
  if ! grep -q "$topic" ./docs/guia_construcao.md; then
    echo "Erro: Tópico '$topic' não encontrado na documentação."
    exit 1
  fi
done

echo "Checklist de validação de documentação aprovado."
