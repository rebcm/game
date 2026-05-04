# Critérios de Aceitação para SLA de Performance

## Introdução

Este documento define os critérios de aceitação para os SLAs (Service Level Agreements) de performance do aplicativo.

## Critérios de Aceitação

1. **Tempo de Build**: O tempo de build do aplicativo não deve exceder 3 segundos.
2. **Tempo de Inicialização**: O tempo de inicialização do aplicativo não deve exceder 5 segundos.

## Testes

Os testes de performance são executados automaticamente como parte do pipeline de CI/CD. Os testes verificam se os critérios de aceitação são atendidos.

## Referência

- [build_performance_test.dart](../test/performance_tests/build_performance_test/build_performance_test.dart)
- [app_startup_performance_test.dart](../test/performance_tests/app_startup_performance_test/app_startup_performance_test.dart)
{"pt-BR": "Tradução para pt-BR"}
