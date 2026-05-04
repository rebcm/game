#!/bin/bash

# Extrair dependências do pubspec.yaml
dependencies=$(yq e '.dependencies | keys | .[]' pubspec.yaml)

# Verificar se a documentação de instalação contém todas as dependências
for dependency in $dependencies; do
  if ! grep -q "$dependency" .github/docs/dependencies/pubspec_dependencies.md; then
    echo "Erro: $dependency não encontrado na documentação de instalação."
    exit 1
  fi
done

echo "Validação da documentação de instalação concluída com sucesso."
