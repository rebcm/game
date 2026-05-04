#!/bin/bash

# Atualiza a documentação de análise de logs

# Verifica se o diretório de documentação existe
if [ ! -d "./.github/docs/flutter_log_analysis" ]; then
  mkdir -p ./.github/docs/flutter_log_analysis
fi

# Copia o conteúdo do guia de análise de logs para o arquivo de documentação
cp ./.github/docs/flutter_log_analysis/log_analysis_guide.md ./.github/docs/flutter_log_analysis/log_analysis_guide.md

echo "Documentação de análise de logs atualizada com sucesso!"
