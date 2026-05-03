#!/bin/bash

# Diretório de assets de áudio
ASSETS_DIR="assets/audio"

# Verificar se o FFmpeg está instalado
if ! command -v ffmpeg &> /dev/null; then
    echo "FFmpeg não está instalado. Por favor, instale-o antes de continuar."
    exit 1
fi

# Loop pelos arquivos de áudio no diretório
for file in "$ASSETS_DIR"/*.{mp3,wav}; do
    # Verificar se o arquivo existe
    if [ -f "$file" ]; then
        # Extrair o nome do arquivo sem a extensão
        filename=$(basename -- "$file")
        filename="${filename%.*}"
        
        # Converter o arquivo para o formato AAC com bitrate otimizado
        ffmpeg -i "$file" -c:a aac -b:a 128k "$ASSETS_DIR/$filename.aac"
        
        # Remover o arquivo original (opcional, descomente se desejar)
        # rm "$file"
    fi
done

echo "Compressão de áudio concluída."
