# Especificação de Integração Física-Gameplay

## Introdução

Este documento define como os eventos de colisão e forças físicas devem disparar eventos de jogo no Rebcm Game.

## Eventos de Colisão

Os eventos de colisão são gerados quando o jogador (Rebeca) colide com blocos ou outros objetos no jogo. As seguintes regras devem ser seguidas:

1. **Detecção de Colisão**: A detecção de colisão deve ser feita utilizando a engine de física do Flame.
2. **Tipos de Colisão**: Devem ser tratados os seguintes tipos de colisão:
   - Colisão com blocos sólidos.
   - Colisão com blocos não sólidos (ex: água, lava).

## Forças Físicas

As forças físicas afetam o movimento e estado do jogador. As seguintes regras devem ser seguidas:

1. **Gravidade**: A gravidade deve ser aplicada ao jogador, afetando sua queda.
2. **Impacto**: O impacto de uma queda deve ser calculado e, se necessário, acionar eventos de jogo (ex: dano ao jogador).

## Eventos de Jogo

Os eventos de jogo são acionados com base nos eventos de colisão e forças físicas. As seguintes regras devem ser seguidas:

1. **Checkpoint**: Ao atingir um checkpoint, o estado do jogo deve ser salvo.
2. **Dano por Queda**: Se o impacto de uma queda exceder um limiar definido, o jogador deve sofrer dano.

## Implementação

A implementação deve seguir as melhores práticas do Flutter e Flame, utilizando os pacotes e estruturas já definidos no projeto.

