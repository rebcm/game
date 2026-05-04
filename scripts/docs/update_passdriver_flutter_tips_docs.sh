#!/bin/bash

# Script para atualizar a documentação do Passdriver Flutter

# Verifica se o arquivo de dicas existe
if [ ! -f ./.github/docs/passdriver_flutter_tips/tips.md ]; then
  echo "Arquivo de dicas não encontrado. Criando..."
  mkdir -p ./.github/docs/passdriver_flutter_tips
  cat > ./.github/docs/passdriver_flutter_tips/tips.md << 'EOF2'
# Passdriver Flutter Dicas Obrigatórias

Este documento lista as dicas e instruções necessárias para a construção do Passdriver Flutter.

## Dicas de Construção

1. **Configuração Inicial**: Certifique-se de configurar corretamente o ambiente de desenvolvimento Flutter.
2. **Dependências**: Verifique as dependências listadas no `pubspec.yaml` e certifique-se de que estão atualizadas.
3. **Testes**: Execute os testes de integração e unitários regularmente para garantir a estabilidade do código.

## Instruções de Implementação

1. **Implementação de Novos Recursos**: Antes de iniciar a implementação de novos recursos, consulte a equipe técnica para alinhamento.
2. **Padrões de Código**: Siga os padrões de código estabelecidos no projeto para manter a consistência.
3. **Documentação**: Mantenha a documentação atualizada conforme novos recursos são implementados.

## Boas Práticas

1. **Revisão de Código**: Solicite revisão de código para todas as alterações significativas.
2. **Testes Automatizados**: Utilize testes automatizados para validar a funcionalidade do código.
3. **Monitoramento de Desempenho**: Monitore o desempenho da aplicação regularmente.

EOF2
fi

# Atualiza o arquivo de dicas
echo "Atualizando arquivo de dicas..."
cat > ./.github/docs/passdriver_flutter_tips/tips.md << 'EOF2'
# Passdriver Flutter Dicas Obrigatórias

Este documento lista as dicas e instruções necessárias para a construção do Passdriver Flutter.

## Dicas de Construção

1. **Configuração Inicial**: Certifique-se de configurar corretamente o ambiente de desenvolvimento Flutter.
2. **Dependências**: Verifique as dependências listadas no `pubspec.yaml` e certifique-se de que estão atualizadas.
3. **Testes**: Execute os testes de integração e unitários regularmente para garantir a estabilidade do código.

## Instruções de Implementação

1. **Implementação de Novos Recursos**: Antes de iniciar a implementação de novos recursos, consulte a equipe técnica para alinhamento.
2. **Padrões de Código**: Siga os padrões de código estabelecidos no projeto para manter a consistência.
3. **Documentação**: Mantenha a documentação atualizada conforme novos recursos são implementados.

## Boas Práticas

1. **Revisão de Código**: Solicite revisão de código para todas as alterações significativas.
2. **Testes Automatizados**: Utilize testes automatizados para validar a funcionalidade do código.
3. **Monitoramento de Desempenho**: Monitore o desempenho da aplicação regularmente.

EOF2

echo "Documentação do Passdriver Flutter atualizada com sucesso!"
