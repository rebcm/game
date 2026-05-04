# Critérios de Aceitação para Testes de Carga

## Introdução

Este documento define os critérios de aceitação para os testes de carga do jogo Construção Criativa da Rebeca. Os testes de carga são essenciais para garantir que o jogo possa suportar diferentes níveis de densidade de blocos e distâncias de renderização sem comprometer a performance.

## Matriz de Testes de Carga

A matriz de testes de carga define os valores exatos para densidade de blocos e distância de renderização que serão utilizados nos testes. A matriz é composta pelas seguintes variáveis:

| Densidade de Blocos | Distância de Renderização | FPS Esperado |
|---------------------|---------------------------|--------------|
| Mínimo              | Mínimo                    | >= 60        |
| Mínimo              | Médio                     | >= 60        |
| Mínimo              | Máximo                    | >= 30        |
| Médio               | Mínimo                    | >= 60        |
| Médio               | Médio                     | >= 45        |
| Médio               | Máximo                    | >= 20        |
| Máximo              | Mínimo                    | >= 30        |
| Máximo              | Médio                     | >= 20        |
| Máximo              | Máximo                    | >= 15        |

## Critérios de Aceitação

1. O jogo deve manter uma taxa de frames por segundo (FPS) igual ou superior aos valores definidos na matriz de testes de carga.
2. A performance do jogo não deve ser afetada negativamente pela densidade de blocos ou distância de renderização.
3. Os testes de carga devem ser realizados em diferentes dispositivos para garantir compatibilidade.

## Conclusão

Os critérios de aceitação definidos neste documento garantem que o jogo Construção Criativa da Rebeca seja estável e performático sob diferentes condições de carga. A matriz de testes de carga fornece uma base sólida para a realização de testes rigorosos e para a identificação de áreas que necessitam de otimização.
