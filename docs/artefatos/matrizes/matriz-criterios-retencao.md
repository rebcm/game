# Matriz de Critérios de Aceitação para Retenção

## Introdução

Este documento define os critérios de aceitação para a retenção de versões e artefatos no repositório do jogo Rebeca. A retenção adequada é crucial para garantir a integridade do projeto, facilitar a manutenção e o debugging, além de otimizar o uso de recursos de armazenamento.

## Critérios de Retenção

### 1. Tempo de Expiração (TTL)

*   Todas as versões de branches não principais (não `main`) serão retidas por um período de 30 dias.
*   Versões da branch `main` serão retidas por um período de 180 dias.
*   Tags imutáveis criadas para releases oficiais não expiram.

### 2. Número Máximo de Versões por Branch

*   Para branches não principais, serão mantidas no máximo as últimas 10 versões.
*   Para a branch `main`, serão mantidas todas as versões dentro do período de retenção definido.

### 3. Lista de Tags Imutáveis

*   Tags no formato `vX.Y.Z` são consideradas imutáveis e não podem ser deletadas.
*   Tags que representam releases oficiais ou marcos importantes do projeto são imutáveis.

## Implementação

A implementação desses critérios será feita através de scripts automatizados que periodicamente limpam versões antigas e verificam a conformidade com os critérios estabelecidos.

## Manutenção

Este documento será revisado anualmente ou sempre que houver mudanças significativas no projeto que possam afetar os critérios de retenção.

