# Especificação de Movimentação do Jogador

## Visão Geral

Este documento descreve a implementação dos gatilhos de movimentação do jogador no jogo Construção Criativa da Rebeca.

## Gatilhos de Movimentação

Os gatilhos de movimentação são inputs específicos que disparam a mudança de estado de Idle para Walking.

### Inputs Válidos

- Teclas de seta (arrowUp, arrowDown, arrowLeft, arrowRight)
- Teclas W, A, S, D (keyW, keyA, keyS, keyD)

## Estado do Jogador

O estado do jogador é representado pela classe `PlayerState`, que pode ser:
- Idle (ocioso)
- Walking (caminhando)

## Implementação

A classe `PlayerMovement` é responsável por lidar com os inputs e atualizar o estado do jogador.

### Testes

Testes unitários foram implementados para garantir a corretude da implementação.
