# Critérios de Aceitação para Retenção

## Introdução

Este documento define os critérios de aceitação para a retenção de versões e artefatos no repositório.

## Critérios

1. **TTL (Tempo de Expiração)**: Definir o tempo máximo que uma versão ou artefato pode ser mantido no repositório.
2. **Número Máximo de Versões por Branch**: Definir o número máximo de versões que podem ser mantidas por branch.
3. **Tags Imutáveis**: Definir a lista de tags que não podem ser deletadas ou modificadas.

## Parâmetros

* TTL: 30 dias
* Número Máximo de Versões por Branch: 10
* Tags Imutáveis:
 + `v*.*.*` (versões semânticas)
 + `release-*` (releases)

## Validação

A validação dos critérios de aceitação será realizada automaticamente através do workflow `.github/workflows/retencao_validacao/criterios_aceitacao_retencao.yml`.
