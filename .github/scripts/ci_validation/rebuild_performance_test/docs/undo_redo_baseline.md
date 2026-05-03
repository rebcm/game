# Baseline de Performance para Undo/Redo

Este documento define a baseline de performance para operações de Undo/Redo no jogo.

## Critérios de Aceitação

- O número máximo de rebuilds permitidos durante uma operação de Undo/Redo é de 50.
- O tempo máximo para realizar uma operação de Undo/Redo é de 100ms.

## Métricas de Avaliação

- Número de rebuilds durante a operação de Undo/Redo.
- Tempo necessário para realizar a operação de Undo/Redo.

## Testes de Performance

Os testes de performance serão realizados utilizando o framework de testes de integração do Flutter.

