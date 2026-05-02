# Matriz de Severidade de Stuttering

Este documento define as faixas de tolerância para stuttering no jogo, visando evitar falsos positivos em oscilações irrelevantes.

## Critérios de Avaliação

| Faixa de Jank Frames | Status  | Descrição                     |
|----------------------|---------|-------------------------------|
| 0-2%                 | Pass    | Performance aceitável        |
| 2-10%                | Warning | Atenção: possível otimização |
| >10%                 | Fail    | Performance inaceitável      |

## Justificativa

As faixas foram definidas com base nos padrões de performance esperados para jogos voxel criativos, considerando a experiência do usuário e a necessidade de otimização.

## Implementação

Para implementar essa matriz, é necessário integrar métricas de jank frames nos testes de performance do jogo, utilizando ferramentas como o Flutter Driver.

## Referências

- [Flutter Driver](https://api.flutter.dev/flutter/flutter_driver/flutter_driver-library.html)
