#!/bin/bash

# Sincroniza a documentação com as variáveis de ambiente e dependências

# Verifica se os arquivos .env e pubspec.yaml foram alterados
if git diff --quiet HEAD~1 -- .env pubspec.yaml; then
  echo "Nenhuma alteração detectada em .env ou pubspec.yaml"
  exit 0
fi

# Atualiza a documentação de variáveis de ambiente
echo "Atualizando documentação de variáveis de ambiente..."
cat > .github/docs/env_validation.md << 'DOC_EOF'
# Validação das Variáveis de Ambiente

Este documento descreve as variáveis de ambiente utilizadas pelo projeto.

## Variáveis de Ambiente

As seguintes variáveis de ambiente são utilizadas:

$(grep -v '^#' .env | sed 's/^/ - /')
DOC_EOF

# Atualiza a documentação de dependências
echo "Atualizando documentação de dependências..."
cat > .github/docs/dependencies/pubspec_dependencies.md << 'DOC_EOF'
# Dependências do Projeto

Este documento lista as dependências do projeto conforme especificado no `pubspec.yaml`.

## Dependências

$(yq e '.dependencies | keys | .[]' pubspec.yaml | sed 's/^/ - /')

## Dependências de Desenvolvimento

$(yq e '.dev_dependencies | keys | .[]' pubspec.yaml | sed 's/^/ - /')
DOC_EOF

echo "Documentação sincronizada com sucesso!"
