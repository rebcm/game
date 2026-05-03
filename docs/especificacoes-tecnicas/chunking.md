# Especificações Técnicas de Chunking

## Tamanho dos Chunks
Os chunks têm um tamanho de 16x16 blocos.

## Cache de Chunks Vizinhos
Mantemos em cache os chunks vizinhos imediatos (3x3 ao redor do chunk atual), totalizando 9 chunks.

## Lógica de Unloading
Os chunks são descarregados quando estão a uma distância de 2 chunks do chunk atual em qualquer direção. Isso significa que quando o jogador se afasta o suficiente, os chunks que não estão mais próximos são removidos da memória para evitar memory leaks.

## Implementação
A lógica de chunking é implementada de forma a garantir que apenas os chunks necessários estejam carregados na memória. Isso envolve carregar chunks adjacentes ao chunk atual e descarregar aqueles que estão além da distância definida.

