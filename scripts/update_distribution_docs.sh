#!/bin/bash

# Atualiza a documentação do processo de distribuição
# Deve ser executado manualmente quando necessário

# Atualiza o arquivo de documentação
cp .github/docs/distribution_process_documentation/distribution_process.md .github/docs/distribution_process_documentation/distribution_process_last.md

# Gera a nova documentação
flutter pub run flutter_distributor generate

# Atualiza o arquivo de documentação com as novas informações
echo "# Processo de Distribuição do Jogo" > .github/docs/distribution_process_documentation/distribution_process.md
echo "" >> .github/docs/distribution_process_documentation/distribution_process.md
cat .github/docs/distribution_process_documentation/distribution_process_last.md >> .github/docs/distribution_process_documentation/distribution_process.md

# Remove o arquivo temporário
rm .github/docs/distribution_process_documentation/distribution_process_last.md

echo "Documentação do processo de distribuição atualizada com sucesso!"
