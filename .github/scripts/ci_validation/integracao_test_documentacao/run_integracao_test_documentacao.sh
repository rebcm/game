#!/bin/bash

# Este script executa os testes de integração da documentação
# Verifica se a documentação está atualizada e consistente com o código

# Configura o ambiente para execução dos testes
source ./env.sh

# Executa os testes de integração da documentação
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart

# Verifica se houve erros durante a execução dos testes
if [ $? -ne 0 ]; then
  echo "Erro ao executar testes de integração da documentação"
  exit 1
fi

echo "Testes de integração da documentação executados com sucesso"
