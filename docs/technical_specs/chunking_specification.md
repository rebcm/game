# Especificações Técnicas de Chunking

## Tamanho dos Chunks
Os chunks têm um tamanho de 16x16 voxels.

## Cache de Chunks Vizinhos
O sistema mantém em cache os 8 chunks vizinhos mais próximos ao chunk atual. Isso ajuda a melhorar a performance durante a navegação pelo mundo voxel.

## Lógica de Unloading de Chunks
Para evitar memory leaks, os chunks são descarregados quando estão a uma distância de 3 chunks ou mais do chunk atual. Isso garante que apenas os chunks relevantes para a experiência atual do usuário sejam mantidos na memória.

## Implementação
A lógica de chunking é implementada de forma a garantir que os chunks sejam carregados e descarregados de maneira eficiente, minimizando o impacto na performance do jogo.

