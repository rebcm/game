# Baseline de Performance para Undo/Redo

Este documento define a baseline de performance para a operação de Undo/Redo no jogo.

## Critérios de Aceitação

- O número máximo de rebuilds permitidos durante uma operação de Undo/Redo é de 50.
- A latência média para a operação de Undo/Redo não deve exceder 100ms.

## Metodologia de Teste

1. Executar o teste de performance de rebuild utilizando o script `run_rebuild_performance_test.sh`.
2. Medir o número de rebuilds e a latência durante a operação de Undo/Redo.
3. Comparar os resultados com os critérios de aceitação definidos acima.

## Resultados Esperados

- Número de rebuilds: <= 50
- Latência média: <= 100ms

