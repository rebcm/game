# Critérios de Aceitação para Edge Cases de Física

Este documento descreve os comportamentos esperados para casos extremos no jogo, incluindo colisões em altíssima velocidade, sobreposição de objetos (clipping) e comportamento do veículo ao capotar.

## Colisões em Altíssima Velocidade

1. O jogo deve ser capaz de lidar com colisões em altíssima velocidade sem crashar ou apresentar comportamento instável.
2. Objetos envolvidos na colisão devem se comportar de acordo com as leis da física implementadas no jogo.
3. A integridade dos objetos após a colisão deve ser mantida de acordo com as regras do jogo.

## Sobreposição de Objetos (Clipping)

1. O jogo deve detectar e prevenir a sobreposição de objetos, garantindo que eles não se sobreponham uns aos outros.
2. Em casos onde a sobreposição é inevitável devido à alta velocidade ou outros fatores, o jogo deve lidar com a situação de forma graciosa, seja resolvendo a sobreposição ou apresentando um comportamento definido para tal situação.

## Comportamento do Veículo ao Capotar

1. Quando o veículo capotar, o jogo deve simular o comportamento físico realista, considerando fatores como velocidade, direção e superfície de impacto.
2. O veículo deve responder de forma apropriada ao capotar, seja continuando a se mover de acordo com a física ou parando, dependendo das regras do jogo.

## Testes e Validação

1. Testes devem ser realizados para garantir que os critérios acima são atendidos em diferentes cenários e configurações do jogo.
2. Os resultados dos testes devem ser documentados e utilizados para ajustar os parâmetros do jogo conforme necessário.

