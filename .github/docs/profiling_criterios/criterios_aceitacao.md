# Critérios de Aceitação para Profiling de Rebuilds da Cena 3D

## Introdução

Este documento define os critérios de aceitação para a tarefa de profiling de rebuilds da cena 3D durante operações de Undo/Redo.

## Critérios

1. O teste de profiling deve ser implementado usando Flutter Test.
2. O teste deve medir o tempo necessário para realizar operações de Undo/Redo.
3. O teste deve contar o número de rebuilds durante as operações de Undo/Redo.
4. O teste deve imprimir os resultados no console.
5. O número de rebuilds deve ser menor que um threshold definido (inicialmente 100).

## Aceitação

A tarefa será considerada aceita quando todos os critérios acima forem atendidos.
