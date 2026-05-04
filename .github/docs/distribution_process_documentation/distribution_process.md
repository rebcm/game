# Processo de Distribuição

## Introdução

Este documento descreve o processo de distribuição dos binários do jogo Rebeca, gerados pelo pipeline de CI/CD.

## Geração de Binários

Os binários são gerados pelo pipeline de CI/CD configurado no arquivo `.github/workflows/main.yml`. O pipeline utiliza o Flutter para compilar o código e gerar os executáveis para as plataformas suportadas.

## Localização dos Binários

Após a execução bem-sucedida do pipeline, os binários são armazenados em um diretório específico dentro do repositório. A localização exata dos binários pode ser encontrada na seção "Artefatos" do pipeline no GitHub.

## Distribuição

Os binários gerados são distribuídos automaticamente para os canais de distribuição configurados, como o GitHub Releases.

## Configuração

A configuração do processo de distribuição é feita no arquivo `.github/workflows/main.yml`. Este arquivo define as etapas do pipeline, incluindo a geração de binários e a distribuição.

## Verificação

Para verificar a integridade dos binários gerados, é possível verificar os checksums disponíveis na seção "Artefatos" do pipeline.

