#!/bin/bash

MODULE_NAME=$1

mkdir -p ./.github/docs/${MODULE_NAME}

cat > ./.github/docs/${MODULE_NAME}/${MODULE_NAME}.md << 'EOF2'
# ${MODULE_NAME}

## Visão Geral

Descrição geral do módulo ${MODULE_NAME}.

## Funcionalidades

Lista de funcionalidades do módulo ${MODULE_NAME}.

## Requisitos

Lista de requisitos do módulo ${MODULE_NAME}.

## Implementação

Descrição da implementação do módulo ${MODULE_NAME}.

## Testes

Descrição dos testes realizados no módulo ${MODULE_NAME}.

## Checklist de Verificação

- [ ] Funcionalidade 1 implementada
- [ ] Funcionalidade 2 implementada
- [ ] Testes realizados

## Histórico de Alterações

Lista de alterações realizadas no módulo ${MODULE_NAME}.
EOF2

chmod +x ./scripts/create_module_docs.sh
