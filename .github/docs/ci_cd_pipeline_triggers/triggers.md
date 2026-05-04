# Gatilhos e Eventos do Pipeline de CI/CD

## Introdução

Este documento detalha os eventos que disparam o pipeline de CI/CD e as branches monitoradas para o projeto `rebcm/game`.

## Gatilhos do Pipeline

O pipeline de CI/CD é disparado pelos seguintes eventos:

1. **Push**: O pipeline é executado quando há um push para as branches especificadas.
2. **Merge Request**: O pipeline é executado quando um merge request é criado ou atualizado para as branches especificadas.
3. **Tags**: O pipeline é executado quando uma tag é criada ou atualizada.

## Branches Monitoradas

As seguintes branches são monitoradas pelo pipeline de CI/CD:

1. **main**: A branch principal do projeto.
2. **develop**: A branch de desenvolvimento do projeto.
3. **feature/**: Todas as branches que começam com `feature/` são monitoradas.

## Configuração

A configuração do pipeline de CI/CD é feita no arquivo `.github/workflows/ci_cd.yml`.

