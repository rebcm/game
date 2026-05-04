# Estratégia de Fallback de Conteúdo

## Introdução

Este documento define a estratégia de fallback de conteúdo para o jogo Rebeca, garantindo que o usuário nunca veja uma tela vazia em caso de falha na carga de conteúdo.

## Hierarquia de Fallback

A hierarquia de fallback será implementada da seguinte forma:

1. **API**: O jogo tentará carregar o conteúdo da API configurada.
2. **Local**: Caso a API esteja indisponível, o jogo tentará carregar o conteúdo armazenado localmente.
3. **Hardcoded**: Se o conteúdo local não estiver disponível, o jogo utilizará conteúdo hardcoded como último recurso.

## Implementação

A implementação da estratégia de fallback será realizada da seguinte forma:

- Verificar a disponibilidade da API e carregar o conteúdo da mesma, se disponível.
- Caso a API esteja indisponível, verificar a existência de conteúdo local e carregá-lo.
- Se não houver conteúdo local, utilizar o conteúdo hardcoded.

## Testes

Serão implementados testes para garantir que a estratégia de fallback esteja funcionando corretamente.

## Conclusão

A implementação da estratégia de fallback de conteúdo garantirá uma melhor experiência para o usuário, evitando que ele veja telas vazias em caso de falha na carga de conteúdo.
