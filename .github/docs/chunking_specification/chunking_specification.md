# Especificação de Chunking

## Tamanho do Chunk
O tamanho do chunk é definido como 16x16 blocos.

## Margem de Pré-carregamento (Buffer Zone)
A margem de pré-carregamento ao redor do jogador é de 2 chunks.

## Implementação
A implementação do chunking seguirá as seguintes diretrizes:
- Os chunks serão carregados e descarregados dinamicamente com base na posição do jogador.
- A margem de pré-carregamento será utilizada para carregar chunks adjacentes ao chunk atual do jogador.
{"pt-BR": "Tradução para pt-BR"}
