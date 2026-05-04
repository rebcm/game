# Critérios de Aceitação para Paginação de Listagens

## Introdução

Este documento define os critérios de aceitação para a implementação da paginação nas listagens de Motoristas e Histórico de Viagens no aplicativo Flutter do projeto Rebcm.

## Requisitos Funcionais

1. **Parâmetros de Paginação**: Os endpoints de listagem devem aceitar os parâmetros `page` e `limit` (ou `offset`) para controlar a paginação.
2. **Resposta Paginada**: As respostas dos endpoints devem incluir metadados de paginação, como total de itens, página atual e total de páginas.
3. **Tratamento de Erros**: O aplicativo deve tratar erros de paginação, como requisições inválidas ou falhas de servidor.
4. **Integração com o Flutter**: A paginação deve ser implementada no aplicativo Flutter, utilizando a biblioteca `dio` para requisições HTTP.

## Critérios de Aceitação

1. Os endpoints de listagem de Motoristas e Histórico de Viagens aceitam os parâmetros `page` e `limit`.
2. As respostas dos endpoints incluem metadados de paginação.
3. O aplicativo Flutter exibe as listagens paginadas corretamente.
4. O aplicativo trata erros de paginação de forma adequada.

## Testes

1. Testes unitários para a lógica de paginação no aplicativo Flutter.
2. Testes de integração para os endpoints de listagem com paginação.
