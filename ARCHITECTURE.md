# Arquitetura do Projeto

## Visão Geral

O projeto Construção Criativa da Rebeca é um jogo voxel criativo desenvolvido em Flutter utilizando o framework Flame.

## Componentes Principais

- **Gerador de Mundo**: Responsável por gerar o mundo do jogo.
- **Rebeca**: Representa o personagem principal do jogo.
- **ColisaoHandler**: Lida com as colisões entre Rebeca e os blocos do mundo.
- **IntegracaoFisicaGameplay**: Integra a física do jogo com a lógica de gameplay.

## Fluxo de Execução

1. O `GeradorMundo` gera o mundo do jogo.
2. A `Rebeca` é inicializada com uma posição e velocidade.
3. O `ColisaoHandler` verifica as colisões entre Rebeca e os blocos do mundo.
4. A `IntegracaoFisicaGameplay` atualiza o estado do jogo com base nas colisões e outras condições físicas.

## Regras de Negócio

- O jogo deve permanecer em modo criativo puro.
- Não deve haver NPCs ou monstros.
- A autoria do projeto deve ser preservada.

## Tecnologias Utilizadas

- Flutter
- Flame
- Dart

## Considerações de Design

- O código deve ser simples, estável e divertido.
- A complexidade desnecessária deve ser evitada.
