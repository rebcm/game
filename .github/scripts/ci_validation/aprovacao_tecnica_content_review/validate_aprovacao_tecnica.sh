#!/bin/bash

# Validação da aprovação técnica do conteúdo
# Verifica se o conteúdo implementado corresponde ao conteúdo aprovado

# Diretório do conteúdo aprovado
CONTENT_APPROVED_DIR=.github/scripts/ci_validation/aprovacao_tecnica_content_review/content_approved

# Diretório do conteúdo implementado
CONTENT_IMPLEMENTED_DIR=assets/content

# Verifica se os diretórios existem
if [ ! -d "$CONTENT_APPROVED_DIR" ]; then
  echo "Diretório de conteúdo aprovado não existe"
  exit 1
fi

if [ ! -d "$CONTENT_IMPLEMENTED_DIR" ]; then
  echo "Diretório de conteúdo implementado não existe"
  exit 1
fi

# Compara o conteúdo aprovado com o implementado
diff -r "$CONTENT_APPROVED_DIR" "$CONTENT_IMPLEMENTED_DIR"

if [ $? -ne 0 ]; then
  echo "Conteúdo implementado não corresponde ao conteúdo aprovado"
  exit 1
fi

echo "Conteúdo implementado validado com sucesso"
exit 0

