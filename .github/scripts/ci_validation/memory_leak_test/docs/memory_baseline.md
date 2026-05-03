# Baseline de Memória

Este documento registra o consumo de memória do jogo antes e depois da destruição do estado_jogo.dart para quantificar o leak em bytes/objetos.

## Metodologia

1. Executar o teste de memória com o estado_jogo.dart ativo.
2. Registrar o consumo de memória.
3. Destruir o estado_jogo.dart.
4. Executar novamente o teste de memória.
5. Registrar o consumo de memória após a destruição.

## Resultados

| Data       | Consumo de Memória Antes | Consumo de Memória Depois | Diferença |
|------------|--------------------------|---------------------------|-----------|
| YYYY-MM-DD | XXX MB                   | YYY MB                    | ZZZ MB    |

