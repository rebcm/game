# Matriz de Retenção de Artefatos

## Introdução

Este documento define a política de retenção de artefatos para o projeto Rebeca. A retenção de artefatos é crucial para garantir a integridade e a rastreabilidade do desenvolvimento do projeto, além de facilitar a recuperação de versões estáveis em caso de necessidade.

## Critérios de Retenção

Os artefatos gerados durante o desenvolvimento do projeto Rebeca são classificados em duas categorias principais: artefatos de `branch/feature` e artefatos de `release/stable`. Cada categoria possui critérios específicos para retenção.

### Artefatos de `branch/feature`

- **TTL (Tempo de Vida)**: 30 dias após a merge ou fechamento da branch.
- **Quantidade Mínima de Versões**: Não há quantidade mínima definida para artefatos de `branch/feature`. Eles são retidos com base no TTL.

### Artefatos de `release/stable`

- **TTL**: Permanente, a menos que seja explicitamente removido devido a obsolescência ou outros motivos justificados.
- **Quantidade Mínima de Versões**: As últimas 5 versões estáveis são mantidas permanentemente.

## Implementação

A implementação da matriz de retenção de artefatos será realizada por meio de scripts automatizados que periodicamente verificam e aplicam as políticas de retenção definidas.

## Conclusão

A matriz de retenção de artefatos é fundamental para o gerenciamento eficaz dos artefatos gerados durante o desenvolvimento do projeto Rebeca. Ela garante que os artefatos sejam retidos por um período adequado, permitindo a recuperação de versões estáveis quando necessário, ao mesmo tempo em que evita a acumulação desnecessária de dados.
