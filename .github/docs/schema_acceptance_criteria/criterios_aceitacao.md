# Critérios de Aceitação para o Schema

## Introdução

Este documento define os critérios de aceitação para o schema utilizado no projeto Rebeca. Os critérios aqui estabelecidos visam garantir a integridade e consistência dos dados armazenados.

## Critérios de Aceitação

1. **Campos NOT NULL**: Todos os campos definidos como NOT NULL não devem permitir a inserção de valores nulos ou vazios.
2. **Chave Primária Única**: A chave primária do schema deve ser única para cada registro, não permitindo duplicatas.
3. **Restrições de Integridade**: O schema deve respeitar as restrições de integridade definidas, garantindo a consistência dos dados.
4. **Validação de Dados**: Os dados inseridos devem ser validados de acordo com as regras de negócio estabelecidas.

## Testes de Aceitação

Os seguintes testes devem ser implementados para validar os critérios de aceitação:

- Teste de inserção de registro com campo NOT NULL vazio
- Teste de inserção de registro com chave primária duplicada
- Teste de validação de dados de acordo com as regras de negócio

## Conclusão

Os critérios de aceitação definidos neste documento devem ser utilizados como referência para o desenvolvimento e teste do schema. A implementação correta desses critérios garantirá a qualidade e integridade dos dados armazenados.
