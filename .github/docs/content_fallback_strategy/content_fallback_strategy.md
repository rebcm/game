# Estratégia de Fallback de Conteúdo

## Introdução

Este documento define a estratégia de fallback de conteúdo para o jogo Rebeca, garantindo que o usuário nunca veja uma tela vazia.

## Hierarquia de Fallback

A hierarquia de fallback é a seguinte:

1. **API**: O jogo tentará carregar o conteúdo da API primeiro.
2. **Local**: Se a API não estiver disponível, o jogo tentará carregar o conteúdo local.
3. **Hardcoded**: Se o conteúdo local não estiver disponível, o jogo utilizará o conteúdo hardcoded.

## Implementação

A implementação da estratégia de fallback será feita da seguinte forma:

*   Criar uma classe de serviço que será responsável por carregar o conteúdo.
*   A classe de serviço tentará carregar o conteúdo da API primeiro.
*   Se a API não estiver disponível, a classe de serviço tentará carregar o conteúdo local.
*   Se o conteúdo local não estiver disponível, a classe de serviço utilizará o conteúdo hardcoded.

## Testes

Serão criados testes unitários e de integração para garantir que a estratégia de fallback esteja funcionando corretamente.

