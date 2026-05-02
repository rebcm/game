# Matriz de Retenção de Artefatos

## Introdução

Este documento define a política de retenção de artefatos para o projeto Rebeca. A retenção de artefatos é crucial para garantir a integridade e a rastreabilidade do desenvolvimento, além de otimizar o uso de recursos de armazenamento.

## Critérios de Retenção

### Artefatos de 'branch/feature'

- **TTL (Tempo de Expiração):** 15 dias após a merge ou fechamento da branch.
- **Quantidade Mínima de Versões:** 3 versões.

### Artefatos de 'release/stable'

- **TTL (Tempo de Expiração):** Indefinido, mantidos permanentemente.
- **Quantidade Mínima de Versões:** Todas as versões lançadas.

## Justificativa

A retenção de artefatos de 'branch/feature' por um período de 15 dias após a merge ou fechamento da branch permite que os desenvolvedores revertam ou comparem versões recentes caso necessário. Manter pelo menos 3 versões garante que haja histórico suficiente para depuração e análise.

Artefatos de 'release/stable' são mantidos indefinidamente, pois representam versões estáveis e lançadas do software. Isso é essencial para garantir a rastreabilidade e permitir a recuperação de qualquer versão lançada.

## Implementação

A implementação da matriz de retenção será realizada através de scripts automatizados que monitoram e limpam os artefatos de acordo com os critérios definidos.

## Conclusão

A política de retenção de artefatos aqui definida visa equilibrar a necessidade de manter um histórico de desenvolvimento com a otimização do uso de recursos de armazenamento. Esta política será revisada periodicamente para garantir que atenda às necessidades em constante evolução do projeto.
