#!/bin/bash

# Validar se o conteúdo da revisão ortográfica e técnica está correto

# Diretório da documentação
DOCS_DIR="docs/peer_review"

# Arquivo específico para validação
TARGET_FILE="task-1777666324-13-sub-6-disc-1777777797-3.md"

# Verificar se o arquivo existe
if [ ! -f "$DOCS_DIR/$TARGET_FILE" ]; then
  echo "Arquivo $TARGET_FILE não encontrado em $DOCS_DIR"
  exit 1
fi

# Validar o conteúdo do arquivo
# Por exemplo, verificar se há erros ortográficos ou de formatação
# Aqui está um exemplo simples usando grep para procurar por TODO ou FIXME
if grep -qE "TODO|FIXME" "$DOCS_DIR/$TARGET_FILE"; then
  echo "Conteúdo do arquivo $TARGET_FILE contém TODO ou FIXME"
  exit 1
fi

echo "Validação do conteúdo de $TARGET_FILE concluída com sucesso"
exit 0

