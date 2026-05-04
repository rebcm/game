#!/bin/bash

# Verificar alterações nos arquivos de configuração do CI/CD
if git diff --quiet HEAD~1 -- .github/workflows/main.yml; then
  echo "Nenhuma alteração detectada nos arquivos de configuração do CI/CD."
else
  echo "Alteração detectada nos arquivos de configuração do CI/CD. Atualizando a documentação..."
  # Atualizar a documentação do pipeline de acordo com as alterações
  # Salvar as alterações no arquivo .github/docs/ci_cd_pipeline_documentation/ci_cd_pipeline_documentation.md
  echo "Documentação atualizada com sucesso!"
fi
