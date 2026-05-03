#!/bin/bash

# Executar flutter doctor e capturar a saída
flutter doctor > flutter_doctor_output.txt 2>&1

# Extrair erros de dependências ausentes
grep -E '(!|X)' flutter_doctor_output.txt | grep -i 'depend' > missing_dependencies.txt

# Documentar os resultados
echo "Flutter Doctor Erros de Dependências Ausentes:" > flutter_doctor_results.md
cat missing_dependencies.txt >> flutter_doctor_results.md

# Limpar arquivos temporários
rm flutter_doctor_output.txt missing_dependencies.txt
