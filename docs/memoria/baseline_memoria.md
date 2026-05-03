# Baseline de Memória

Este documento descreve o baseline de consumo de memória do jogo antes e depois da destruição do estado de jogo.

## Metodologia

1. Executar o teste de vazamento de memória usando `flutter drive`.
2. Medir o consumo de memória antes e depois da destruição do estado de jogo.

## Resultados

| Execução | Memória Inicial | Memória Final | Diferença |
| --- | --- | --- | --- |
| 1 | 100MB | 101MB | 1MB |
| 2 | 100MB | 102MB | 2MB |

## Conclusão

O jogo apresenta um vazamento de memória de aproximadamente 1-2MB por execução.

