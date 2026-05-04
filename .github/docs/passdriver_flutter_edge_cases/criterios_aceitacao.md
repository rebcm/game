# Critérios de Aceitação para Edge Cases de Física

Este documento descreve os comportamentos esperados para casos extremos no jogo, incluindo colisões em altíssima velocidade, sobreposição de objetos (clipping) e comportamento do veículo ao capotar.

## Colisões em Altíssima Velocidade

1. O jogo deve ser capaz de lidar com colisões em altíssima velocidade sem crashar ou apresentar comportamentos inconsistentes.
2. Objetos colidindo em altíssima velocidade devem ter sua física simulada corretamente, sem atravessar outros objetos ou causar instabilidade na simulação.

## Sobreposição de Objetos (Clipping)

1. O jogo deve detectar e prevenir a sobreposição de objetos, garantindo que eles não se sobreponham uns aos outros.
2. Em casos onde a sobreposição ocorre devido a limitações da engine ou bugs, o jogo deve se recuperar graciosamente, minimizando a visibilidade do problema.

## Comportamento do Veículo ao Capotar

1. Quando o veículo capota, o jogo deve simular o comportamento físico correto, incluindo rotação e resposta às entradas do jogador.
2. O veículo deve responder corretamente às ações do jogador mesmo após capotar, permitindo que o jogador o endireite ou continue dirigindo.

## Testes e Validação

1. Testes automatizados devem ser implementados para validar esses comportamentos, garantindo que mudanças futuras no código não introduzam regressões.
2. Os critérios de aceitação devem ser verificados regularmente como parte do processo de CI/CD.

