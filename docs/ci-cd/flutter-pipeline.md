# Pipeline de CI/CD do Flutter

## Introdução

Este documento descreve o pipeline diário de CI/CD do aplicativo Flutter da PassDriver.

## Etapas do Pipeline

1. **Build**: Compilação do aplicativo Flutter para Android e iOS.
2. **Testes Unitários**: Execução de testes unitários para garantir a integridade do código.
3. **Testes de Integração**: Execução de testes de integração para garantir a funcionalidade do aplicativo.
4. **Análise de Código**: Análise estática do código para detectar problemas de qualidade e segurança.
5. **Deploy**: Deploy do aplicativo para os ambientes de staging e produção.

## Horários

* O pipeline é executado diariamente às 02h00 UTC.
* O deploy para o ambiente de staging ocorre às 03h00 UTC.
* O deploy para o ambiente de produção ocorre às 04h00 UTC, após aprovação manual.

## Ferramentas Utilizadas

* GitHub Actions para automação do pipeline.
* Flutter para build e testes do aplicativo.
* Codecov para análise de cobertura de testes.
* SonarQube para análise estática do código.

