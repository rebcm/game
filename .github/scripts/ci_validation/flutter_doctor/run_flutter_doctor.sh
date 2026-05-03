#!/bin/bash

echo "Executando Flutter Doctor..."
flutter doctor --verbose > flutter_doctor_output.log 2>&1

echo "Analisando resultados do Flutter Doctor..."
if grep -q "No issues found!" flutter_doctor_output.log; then
  echo "Nenhum problema encontrado."
else
  echo "Problemas encontrados. Veja flutter_doctor_output.log para detalhes."
  cat flutter_doctor_output.log
  exit 1
fi
