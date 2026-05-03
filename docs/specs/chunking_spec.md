# Especificações de Chunking

## Tamanho do Chunk
O tamanho do chunk é definido como 16x16 blocos.

## Margem de Pré-carregamento (Buffer Zone)
A margem de pré-carregamento ao redor do jogador é definida como 2 chunks.

## Implementação
A implementação do chunking seguirá as seguintes diretrizes:
- Os chunks serão carregados e descarregados com base na posição do jogador.
- A margem de pré-carregamento será usada para carregar chunks adjacentes ao chunk atual do jogador.
- O tamanho do chunk será usado para determinar a quantidade de blocos a serem carregados e descarregados.

## Exemplo de Cálculo
Se o jogador estiver no chunk (0, 0), os chunks carregados serão:
- (0, 0)
- (-1, -1), (-1, 0), (-1, 1)
- (0, -1), (0, 1)
- (1, -1), (1, 0), (1, 1)

Totalizando 9 chunks carregados.
