# Mapeamento de Requisitos de Dados do Passdriver Flutter

## Introdução

Este documento visa classificar os tipos de dados utilizados pelo passdriver Flutter quanto ao volume, frequência de acesso e necessidade de consistência, justificando a escolha entre armazenamento em KV, R2 e D1.

## Tipos de Dados

1. **Dados de Configuração**
   - **Volume:** Baixo
   - **Frequência de Acesso:** Média
   - **Necessidade de Consistência:** Forte
   - **Justificativa:** Utilizar D1 devido à necessidade de consistência forte e baixa volumetria.

2. **Dados de Estado do Jogo**
   - **Volume:** Médio
   - **Frequência de Acesso:** Alta
   - **Necessidade de Consistência:** Forte
   - **Justificativa:** Utilizar R2 devido à alta frequência de acesso e necessidade de consistência.

3. **Dados de Usuário**
   - **Volume:** Baixo
   - **Frequência de Acesso:** Média
   - **Necessidade de Consistência:** Forte
   - **Justificativa:** Utilizar D1 devido à necessidade de consistência forte.

4. **Metadados de Blocos**
   - **Volume:** Alto
   - **Frequência de Acesso:** Baixa
   - **Necessidade de Consistência:** Eventual
   - **Justificativa:** Utilizar KV devido ao alto volume e baixa frequência de acesso.

## Conclusão

A classificação dos dados do passdriver Flutter foi realizada com base em volume, frequência de acesso e necessidade de consistência. As escolhas de armazenamento foram justificadas de acordo com as características de cada tipo de dado.
