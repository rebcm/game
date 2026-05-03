# Especificações de Chunking

## Tamanho dos Chunks

O tamanho dos chunks será fixado em 16x16 blocos. Isso significa que cada chunk terá uma dimensão de 16 blocos na horizontal e 16 blocos na vertical.

## Margem de Pré-carregamento (Buffer Zone)

Será implementada uma margem de pré-carregamento de 2 chunks ao redor do jogador. Isso significa que o jogo carregará os chunks dentro de uma área de 3x3 chunks centrada no chunk onde o jogador está localizado.

## Justificativa

O tamanho de 16x16 foi escolhido por ser um valor que equilibra a granularidade do carregamento de chunks com a complexidade de gerenciamento dos mesmos. A margem de pré-carregamento de 2 chunks foi definida para garantir que o jogador tenha uma experiência suave ao se mover pelo mundo do jogo, carregando antecipadamente os chunks adjacentes.

## Implementação

A implementação dessas especificações será feita ajustando os parâmetros de chunking no código do jogo. Isso incluirá a definição do tamanho dos chunks e a lógica para o pré-carregamento dos chunks ao redor do jogador.
