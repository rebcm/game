#!/bin/bash

# Diretório de entrada e saída
INPUT_DIR="assets/audio/original"
OUTPUT_DIR="assets/audio/compressed"

# Criar diretório de saída se não existir
mkdir -p "$OUTPUT_DIR"

# Percorrer todos os arquivos de áudio no diretório de entrada
for file in "$INPUT_DIR"/*; do
  # Verificar se o arquivo é um arquivo regular (não diretório)
  if [ -f "$file" ]; then
    # Extrair o nome do arquivo sem a extensão
    filename=$(basename "$file")
    filename_no_ext="${filename%.*}"
    
    # Utilizar FFmpeg para converter o arquivo para o formato escolhido (opus) com bitrate otimizado
    ffmpeg -i "$file" -c:a libopus -b:a 128k "$OUTPUT_DIR/$filename_no_ext.opus"
  fi
done
