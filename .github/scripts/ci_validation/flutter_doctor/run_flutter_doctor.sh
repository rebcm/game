#!/bin/bash

# Executar flutter doctor e capturar a saída
flutter doctor > flutter_doctor_output.txt 2>&1

# Extrair erros de dependências ausentes
echo "Erros de dependências ausentes:"
grep -E '(!|Warning:)' flutter_doctor_output.txt | grep -i 'dependency'

# Salvar os erros em um arquivo
grep -E '(!|Warning:)' flutter_doctor_output.txt | grep -i 'dependency' > missing_dependencies.txt

echo "Relatório de 'flutter doctor' gerado em flutter_doctor_output.txt"
echo "Erros de dependências ausentes listados em missing_dependencies.txt"
