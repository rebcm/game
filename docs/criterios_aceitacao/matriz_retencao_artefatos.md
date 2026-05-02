# Matriz de Retenção de Artefatos

## Introdução

Este documento define a política de retenção de artefatos para o projeto Rebeca Creative Blocks (rebcm/game). A retenção de artefatos é crucial para garantir a integridade e a rastreabilidade do desenvolvimento, além de facilitar a recuperação de versões estáveis em caso de necessidade.

## Critérios de Retenção

Os artefatos gerados durante o desenvolvimento são classificados em duas categorias principais: artefatos de `branch/feature` e artefatos de `release/stable`. Cada categoria possui critérios específicos para retenção.

### Artefatos de `branch/feature`

1. **TTL (Tempo de Expiração):** 15 dias após a última atualização ou merge.
2. **Quantidade Mínima de Versões:** 3 versões mais recentes.

### Artefatos de `release/stable`

1. **TTL (Tempo de Expiração):** Nenhum; mantidos indefinidamente.
2. **Quantidade Mínima de Versões:** Todas as versões lançadas oficialmente.

## Justificativa

A política de retenção para artefatos de `branch/feature` visa equilibrar a necessidade de manter um histórico de desenvolvimento com a necessidade de limpar artefatos obsoletos. Já para artefatos de `release/stable`, a retenção indefinida assegura que todas as versões lançadas possam ser recuperadas a qualquer momento.

## Implementação

A implementação desta política será realizada através de scripts automatizados que periodicamente avaliam e limpam os artefatos de acordo com os critérios estabelecidos.

## Revisão e Atualização

Esta política será revisada anualmente ou sempre que houver mudanças significativas no processo de desenvolvimento. Qualquer atualização será documentada e comunicada à equipe de desenvolvimento.
