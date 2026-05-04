#!/bin/bash

# Atualiza a documentação do processo de distribuição
# Deve ser executado manualmente após alterações no pipeline de CI/CD

# Atualiza o arquivo distribution_process.md
echo "Atualizando documentação do processo de distribuição..."
cp ./.github/docs/distribution_process_documentation/distribution_process.md ./.github/docs/distribution_process_documentation/distribution_process_$(date +%Y%m%d%H%M%S).md
echo "Documentação atualizada com sucesso!"
