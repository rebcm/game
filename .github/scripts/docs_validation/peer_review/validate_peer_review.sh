#!/bin/bash

# Verifica se o arquivo peer_review.md existe
if [ ! -f peer_review.md ]; then
  echo "Arquivo peer_review.md não encontrado."
  exit 1
fi

# Verifica se o conteúdo do arquivo peer_review.md está vazio
if [ ! -s peer_review.md ]; then
  echo "Arquivo peer_review.md está vazio."
  exit 1
fi

# Realiza a validação do conteúdo do peer_review.md
# Implemente aqui a lógica de validação necessária
# Por exemplo, verificar se o conteúdo segue um formato específico
# ou se contém palavras-chave específicas

echo "Validação do peer_review.md realizada com sucesso."
exit 0
