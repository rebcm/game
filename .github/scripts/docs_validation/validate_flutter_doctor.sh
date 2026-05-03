#!/bin/bash

# Executar flutter doctor e capturar a saída
flutter doctor > flutter_doctor_output.txt 2>&1

# Extrair erros de dependências ausentes
grep -E '(!|Warning:)' flutter_doctor_output.txt > missing_dependencies.txt

# Limpar arquivos temporários
rm flutter_doctor_output.txt

# Documentar os erros encontrados
echo "Erros de dependências ausentes:" > flutter_doctor_errors.md
cat missing_dependencies.txt >> flutter_doctor_errors.md

# Limpar arquivos temporários
rm missing_dependencies.txt
