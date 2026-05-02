# Pipeline de CI/CD do Flutter

## Introdução

Este documento descreve o pipeline diário de CI/CD do aplicativo Flutter da PassDriver.

## Etapas do Pipeline

1. **Build**: Compilação do aplicativo Flutter para Android e iOS.
2. **Testes**: Execução de testes unitários e de integração.
3. **Análise de Código**: Verificação de qualidade do código utilizando ferramentas de análise estática.
4. **Deploy**: Publicação do aplicativo nas lojas de aplicativos (Google Play Store e Apple App Store).

## Horários

* O pipeline é executado diariamente às 02h00 UTC.
* A etapa de deploy ocorre após a aprovação manual.

## Detalhes das Etapas

### Build

* Utiliza o comando  para compilar o aplicativo para Android e iOS.
* Os artefatos gerados são armazenados em um bucket de armazenamento.

### Testes

* Executa testes unitários e de integração utilizando o framework de testes do Flutter.
* Os resultados dos testes são armazenados em um banco de dados para análise posterior.

### Análise de Código

* Utiliza ferramentas de análise estática para verificar a qualidade do código.
* Os resultados da análise são armazenados em um banco de dados para análise posterior.

### Deploy

* Ocorre após a aprovação manual.
* Utiliza as APIs das lojas de aplicativos para publicar o aplicativo.

