#!/bin/bash

echo "Executando flutter doctor..."
flutter doctor > flutter_doctor_output.txt 2>&1

echo "Verificando erros de dependências ausentes..."
if grep -q "X" flutter_doctor_output.txt; then
  echo "Erros encontrados. Documentando..."
  grep -A 5 "X" flutter_doctor_output.txt > flutter_doctor_errors.txt
  echo "Erros documentados em flutter_doctor_errors.txt"
else
  echo "Nenhum erro encontrado."
fi
