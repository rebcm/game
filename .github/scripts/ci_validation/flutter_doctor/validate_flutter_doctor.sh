#!/bin/bash

# Executar flutter doctor e capturar a saída
flutter doctor > flutter_doctor_output.txt

# Extrair erros relacionados a dependências ausentes
grep -E "(!|Warning:)" flutter_doctor_output.txt > missing_dependencies.txt

# Documentar os erros em um arquivo markdown
echo "# Relatório do Flutter Doctor" > flutter_doctor_report.md
echo "## Erros e Avisos" >> flutter_doctor_report.md
cat missing_dependencies.txt >> flutter_doctor_report.md

# Limpar arquivos temporários
rm flutter_doctor_output.txt missing_dependencies.txt
