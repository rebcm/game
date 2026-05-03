#!/bin/bash

echo "Executando flutter doctor..."
flutter doctor --verbose > flutter_doctor_output.txt

echo "Verificando dependências ausentes..."
missing_dependencies=$(grep -A 5 "X" flutter_doctor_output.txt | grep -oP '(?<=X ).*(?= is not installed)' | sort | uniq)

if [ -n "$missing_dependencies" ]; then
  echo "Dependências ausentes encontradas:"
  echo "$missing_dependencies"
  echo "$missing_dependencies" > missing_dependencies.txt
else
  echo "Nenhuma dependência ausente encontrada."
  echo "" > missing_dependencies.txt
fi
