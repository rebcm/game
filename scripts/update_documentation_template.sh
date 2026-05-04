#!/bin/bash

TEMPLATE_SOURCE=".github/docs/documentacao_template/template.md"
TEMPLATE_TARGET="lib/docs/module_documentation.md"

if [ -f "$TEMPLATE_SOURCE" ]; then
    cp "$TEMPLATE_SOURCE" "$TEMPLATE_TARGET"
    echo "Template atualizado com sucesso."
else
    echo "Erro: Template não encontrado."
fi
