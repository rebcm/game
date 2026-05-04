# Matriz de Testes para Compatibilidade do Flutter SDK

## Introdução

Este documento define a matriz de testes necessária para garantir a compatibilidade do jogo "Construção Criativa da Rebeca" com diferentes versões do Flutter SDK e sistemas operacionais.

## Matriz de Testes

A matriz de testes deve cobrir as seguintes configurações:

| Sistema Operacional | Versão do Flutter SDK |
| --- | --- |
| Windows | 3.16.0 |
| Windows | 3.19.0 (latest) |
| macOS | 3.16.0 |
| macOS | 3.19.0 (latest) |
| Linux | 3.16.0 |
| Linux | 3.19.0 (latest) |

## Critérios de Aceitação

1. O jogo deve compilar sem erros em todas as combinações de sistema operacional e versão do Flutter SDK definidas na matriz.
2. Os testes de integração devem passar em todas as combinações de sistema operacional e versão do Flutter SDK definidas na matriz.
3. O jogo deve executar sem crashes ou comportamentos inesperados em todas as combinações de sistema operacional e versão do Flutter SDK definidas na matriz.

## Implementação

Para implementar a matriz de testes, devem ser criados ou modificados os seguintes arquivos:
- `test_driver/passdriver_flutter_version_check/version_check_test.dart`: deve ser atualizado para incluir testes para as versões do Flutter SDK definidas na matriz.

