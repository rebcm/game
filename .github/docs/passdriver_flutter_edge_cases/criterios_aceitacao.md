# Critérios de Aceitação para Edge Cases de Física

Este documento descreve os comportamentos esperados para casos extremos no jogo, incluindo colisões em altíssima velocidade, sobreposição de objetos (clipping) e comportamento do veículo ao capotar.

## Colisões em Altíssima Velocidade

1. O jogo deve ser capaz de lidar com colisões em altíssima velocidade sem crashar ou apresentar comportamento indefinido.
2. Objetos colidindo em altíssima velocidade devem ter sua velocidade ajustada para evitar tunelamento.
3. A detecção de colisão deve ser precisa, mesmo em altas velocidades.

## Sobreposição de Objetos (Clipping)

1. O jogo deve evitar a sobreposição de objetos voxel.
2. Em casos onde a sobreposição ocorre, o jogo deve corrigir ou mitigar visualmente o clipping.
3. A lógica de detecção de colisão deve prevenir a sobreposição persistente.

## Comportamento do Veículo ao Capotar

1. O veículo deve responder de forma realista ao capotar, incluindo mudanças na física e na renderização.
2. A detecção de capotagem deve ser precisa e baseada na orientação e velocidade do veículo.
3. O jogo deve aplicar as consequências apropriadas ao capotar, como mudança na direção ou na velocidade.

## Testes e Validação

1. Testes automatizados devem ser implementados para validar os critérios acima.
2. Testes manuais devem ser realizados para garantir que os casos extremos sejam cobertos.

