#!/bin/bash

# Valida se as imagens das estruturas sugeridas existem e estão listadas no README.md

README_FILE="./assets/estruturas_sugeridas/README.md"
IMAGES_DIR="./assets/estruturas_sugeridas"

if [ ! -f "$README_FILE" ]; then
  echo "Erro: $README_FILE não encontrado."
  exit 1
fi

LISTED_IMAGES=$(grep -oP '(?<=- )\w+\.png' "$README_FILE")
for image in $LISTED_IMAGES; do
  if [ ! -f "$IMAGES_DIR/$image" ]; then
    echo "Erro: Imagem $image listada no README mas não encontrada em $IMAGES_DIR."
    exit 1
  fi
done

echo "Validação de estruturas sugeridas concluída com sucesso."
