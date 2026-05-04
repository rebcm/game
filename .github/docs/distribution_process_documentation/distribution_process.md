# Processo de Distribuição

## Introdução

Este documento detalha o processo de distribuição dos binários do jogo Rebeca, incluindo como são gerados e onde podem ser encontrados após o pipeline de CI/CD.

## Geração dos Binários

Os binários são gerados através do pipeline de CI/CD configurado no arquivo `.github/workflows/main.yml`. O pipeline utiliza o Flutter para compilar o código e gerar os executáveis para as plataformas suportadas.

### Plataformas Suportadas

- Android
- iOS
- Web

## Pipeline de CI/CD

O pipeline de CI/CD é responsável por:

1. Compilar o código Flutter para as plataformas suportadas.
2. Executar testes automatizados para garantir a qualidade do código.
3. Gerar os binários e armazená-los em um local acessível.

### Configuração do Pipeline

A configuração do pipeline está localizada no arquivo `.github/workflows/main.yml`. Este arquivo define as etapas do pipeline, incluindo a compilação, teste e armazenamento dos binários.

## Armazenamento dos Binários

Os binários gerados são armazenados em um diretório específico dentro do repositório, facilitando o acesso e a distribuição.

### Localização dos Binários

Os binários podem ser encontrados no diretório `build/` após a execução bem-sucedida do pipeline.

## Conclusão

O processo de distribuição dos binários do jogo Rebeca é automatizado através do pipeline de CI/CD. Este documento fornece uma visão geral de como os binários são gerados e onde podem ser encontrados, facilitando a distribuição e o acesso ao jogo.
