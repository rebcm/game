# Mapeamento de Entidades e Volumetria de Dados do Passdriver Flutter

Este documento lista todas as entidades do passdriver Flutter, definindo o tipo de dado, tamanho estimado e frequência de leitura/escrita para justificar a escolha entre KV, R2 ou D1.

## Entidades do Passdriver Flutter

1. **Bloco**
   - Tipo de dado: Estrutura de dados contendo informações do bloco (id, tipo, posição, etc.)
   - Tamanho estimado: ~100 bytes
   - Frequência de leitura/escrita: Alta frequência de leitura e escrita, pois os blocos são constantemente acessados e modificados.

2. **Chunk**
   - Tipo de dado: Conjunto de blocos (matriz 3D de blocos)
   - Tamanho estimado: ~1 KB a ~10 KB (dependendo da quantidade de blocos no chunk)
   - Frequência de leitura/escrita: Média a alta frequência de leitura e escrita, pois os chunks são carregados e salvos conforme o jogador se move.

3. **Configurações do Jogador**
   - Tipo de dado: Preferências do jogador (volume, controles, etc.)
   - Tamanho estimado: ~100 bytes a ~1 KB
   - Frequência de leitura/escrita: Baixa a média frequência de leitura e escrita, pois as configurações são carregadas na inicialização e salvas ocasionalmente.

## Justificativa para Escolha de Armazenamento

- **KV (Key-Value Store):** Adequado para armazenar configurações do jogador devido à baixa frequência de escrita e leitura.
- **R2 (Armazenamento de Blobs):** Pode ser usado para armazenar chunks, pois suporta dados de tamanho variável e pode lidar com a frequência de leitura/escrita dos chunks.
- **D1 (Banco de Dados):** Pode ser considerado para armazenar blocos e chunks se houver necessidade de consultas complexas, mas pode ser excessivo para este caso de uso.

## Conclusão

O armazenamento das entidades do passdriver Flutter pode ser distribuído entre KV para configurações do jogador e R2 para chunks. A escolha exata depende dos requisitos específicos de desempenho e escalabilidade do jogo.
