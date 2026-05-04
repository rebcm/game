# Critérios de Aceitação para Edge Cases de Física

## Introdução

Este documento define os critérios de aceitação para os edge cases de física no jogo, incluindo colisões em altíssima velocidade, sobreposição de objetos (clipping) e comportamento do veículo ao capotar.

## Critérios de Aceitação

### Colisões em Altíssima Velocidade

1. O jogo deve ser capaz de lidar com colisões em altíssima velocidade sem crashar ou congelar.
2. A detecção de colisões deve ser precisa e consistente, mesmo em velocidades extremas.
3. O comportamento dos objetos após a colisão deve ser fisicamente plausível.

### Sobreposição de Objetos (Clipping)

1. O jogo deve evitar a sobreposição de objetos sempre que possível.
2. Em casos onde a sobreposição é inevitável, o jogo deve lidar com ela de forma graciosa, sem causar problemas visuais ou de física.
3. A sobreposição não deve causar comportamentos indesejados ou imprevisíveis nos objetos envolvidos.

### Comportamento do Veículo ao Capotar

1. O veículo deve responder de forma realista quando capota, incluindo mudanças na direção e velocidade.
2. A física do veículo capotando deve ser suave e previsível, sem saltos ou comportamentos erráticos.
3. O jogo deve manter a integridade da simulação física durante e após o capotamento.

## Testes

Os critérios acima devem ser testados em diferentes cenários para garantir a robustez e a consistência do jogo.

