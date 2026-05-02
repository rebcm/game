# Arquitetura do Projeto

## Visão Geral

O projeto segue uma arquitetura modular, com separação clara entre lógica de jogo, renderização e física.

## Integração Física-Gameplay

A integração entre física e gameplay é realizada através da classe `GameplayFisicaIntegracao`, que utiliza o `ColisaoHandler` para detectar colisões e aplicar lógica de gameplay.

## Componentes

- `ColisaoHandler`: responsável por lidar com colisões e detectar eventos de gameplay.
- `GameplayFisicaIntegracao`: integra a lógica de física com a lógica de gameplay.
- `RenderizadorIsometrico`: responsável por renderizar o jogo.

## Fluxo de Dados

O fluxo de dados entre os componentes é o seguinte:

1. `RenderizadorIsometrico` atualiza a lógica de gameplay através de `GameplayFisicaIntegracao`.
2. `GameplayFisicaIntegracao` utiliza `ColisaoHandler` para detectar colisões e aplicar lógica de gameplay.
