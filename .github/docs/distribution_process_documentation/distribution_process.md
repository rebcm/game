# Documentação do Processo de Distribuição

## Introdução

Este documento detalha o processo de distribuição dos binários do jogo Rebeca após a execução do pipeline de CI/CD.

## Geração dos Binários

Os binários são gerados durante a execução do pipeline de CI/CD configurado no arquivo `.github/workflows/main.yml`. O processo envolve as seguintes etapas:

1. Compilação do código Flutter para as plataformas suportadas (Android, iOS, Web, etc.).
2. Criação dos artefatos de distribuição (APKs, IPA, arquivos ZIP, etc.).

## Localização dos Binários

Após a geração, os binários são armazenados em um diretório específico dentro do repositório ou em uma página de releases do GitHub.

## Distribuição

Os binários gerados estão disponíveis para download na página de releases do repositório GitHub.

## Atualização da Documentação

Este documento deve ser atualizado sempre que houver mudanças no processo de distribuição ou na localização dos binários.

## Scripts de Suporte

O script `update_distribution_docs.sh` é utilizado para atualizar automaticamente esta documentação.
