# Critérios de Aceitação para Deploy

## Introdução

Este documento define os critérios de aceitação para o deploy do jogo Rebeca. Os critérios aqui estabelecidos garantem que o jogo seja entregue com qualidade e atenda aos requisitos definidos.

## Critérios de Aceitação

1. **URL Acessível**: A URL do jogo deve ser acessível e não apresentar erros de conexão.
2. **Assets Carregando Corretamente**: Todos os assets (imagens, áudios, etc.) devem ser carregados corretamente.
3. **Tempo de Build dentro do Limite**: O tempo de build do jogo deve estar dentro do limite estabelecido.
4. **Flutter Analyze sem Erros**: O comando `flutter analyze` não deve apresentar erros.
5. **Testes de Integração Passando**: Todos os testes de integração devem passar sem erros.

## Plano de Testes

1. **Testes de Integração**: Executar os testes de integração definidos no arquivo `./.github/workflows/integration-test.yml`.
2. **Testes de Deploy**: Executar os testes de deploy definidos no arquivo `./.github/workflows/deploy-web.yml`.
3. **Verificação Manual**: Realizar uma verificação manual do jogo após o deploy para garantir que todos os assets estão carregando corretamente e que o jogo está funcionando como esperado.

