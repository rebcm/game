# Critérios de Aceitação para Edge Cases de Física

Este documento descreve os comportamentos esperados para casos extremos no jogo, incluindo colisões em altíssima velocidade, sobreposição de objetos (clipping) e comportamento do veículo ao capotar.

## Colisões em Altíssima Velocidade

1. O jogo deve ser capaz de lidar com colisões em altíssima velocidade sem crashar ou apresentar comportamento instável.
2. Objetos colidindo em altíssima velocidade não devem atravessar uns aos outros.
3. A física das colisões deve ser simulada de forma realista, considerando a velocidade e a direção dos objetos envolvidos.

## Sobreposição de Objetos (Clipping)

1. O jogo deve evitar a sobreposição de objetos sempre que possível.
2. Em casos onde a sobreposição ocorre devido a limitações da engine ou bugs, o jogo deve lidar com a situação de forma graciosa, sem crashar ou apresentar artefatos visuais graves.
3. A detecção de colisões deve ser precisa o suficiente para evitar a sobreposição de objetos na maioria dos casos.

## Comportamento do Veículo ao Capotar

1. Quando o veículo capota, o jogo deve simular o comportamento de forma realista, considerando a física envolvida.
2. O veículo deve responder de forma apropriada às ações do jogador após capotar, permitindo que o jogador o controle novamente de forma intuitiva.
3. A câmera deve se comportar de forma estável e não apresentar trepidação excessiva durante e após o capotamento.

## Testes e Validação

1. Testes automatizados devem ser implementados para validar os critérios acima, garantindo que o jogo se comporte conforme o esperado em diferentes cenários.
2. Testes manuais também devem ser realizados para garantir que os casos extremos sejam cobertos e que o jogo seja estável e divertido.

