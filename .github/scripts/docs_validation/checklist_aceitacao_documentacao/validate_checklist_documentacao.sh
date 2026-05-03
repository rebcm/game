#!/bin/bash

# Verifica se o guia de construção segue o template definido
validate_guia_construcao() {
  local guia_construcao_file=$1
  local material=$(grep -oP '(?<=Material: ).*' "$guia_construcao_file")
  local tempo=$(grep -oP '(?<=Tempo: ).*' "$guia_construcao_file")
  local dificuldade=$(grep -oP '(?<=Dificuldade: ).*' "$guia_construcao_file")

  if [ -z "$material" ] || [ -z "$tempo" ] || [ -z "$dificuldade" ]; then
    echo "Erro: Guia de construção não segue o template definido."
    return 1
  fi
}

# Lista de arquivos de guias de construção
guias_construcao_files=($(find docs/guias_construcao -type f -name "*.md"))

for file in "${guias_construcao_files[@]}"; do
  if ! validate_guia_construcao "$file"; then
    exit 1
  fi
done

echo "Checklist de aceitação para documentação validado com sucesso."
