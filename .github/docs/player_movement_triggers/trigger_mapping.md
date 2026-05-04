# Mapeamento de Triggers de Movimentação

## Introdução

Este documento descreve os gatilhos específicos (inputs) que disparam a mudança de estado de Idle para Walking no jogo.

## Triggers de Movimentação

Os triggers de movimentação são definidos pelas teclas 'w', 'a', 's' e 'd'.

## Implementação

A implementação dos triggers de movimentação é feita através da classe `InputService`, que verifica se uma tecla pressionada é uma tecla de movimentação.

A classe `PlayerController` utiliza a `InputService` para determinar se o jogador deve transitar para o estado de Walking ou permanecer no estado de Idle.

## Testes

Foram implementados testes unitários para as classes `PlayerStateMachine`, `InputService` e `PlayerController` para garantir a correta implementação dos triggers de movimentação.
