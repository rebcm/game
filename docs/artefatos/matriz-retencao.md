# Matriz de Retenção de Artefatos

## Introdução

Este documento define a política de retenção de artefatos para o projeto Rebeca. A retenção de artefatos é crucial para garantir a integridade e a rastreabilidade do desenvolvimento, além de facilitar a recuperação de versões estáveis em caso de necessidade.

## Critérios de Retenção

### Artefatos de 'branch/feature'

- **TTL (Tempo de Expiração):** 30 dias após a merge ou fechamento da branch.
- **Quantidade Mínima de Versões:** 5 últimas versões.

### Artefatos de 'release/stable'

- **TTL (Tempo de Expiração):** Indefinido; mantidos permanentemente.
- **Quantidade Mínima de Versões:** Todas as versões lançadas.

## Justificativa

A política de retenção para artefatos de 'branch/feature' visa equilibrar a necessidade de manter um histórico recente de desenvolvimento com a necessidade de liberar espaço de armazenamento. Já para artefatos de 'release/stable', a retenção permanente assegura que todas as versões lançadas possam ser recuperadas a qualquer momento.

## Implementação

A implementação desta política será realizada através de scripts automatizados que periodicamente avaliarão e removerão artefatos conforme os critérios definidos.

