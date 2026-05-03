# Mapeamento de Entidades e Volumetria de Dados

## Introdução

Este documento visa listar todas as entidades do projeto `rebcm/game`, definindo o tipo de dado, tamanho estimado e frequência de leitura/escrita para justificar a escolha entre KV, R2 ou D1 para armazenamento.

## Entidades do Projeto

### 1. Blocos Voxel
- **Tipo de Dado:** Estrutura de dados representando um bloco voxel (ex: tipo de bloco, posição, estado).
- **Tamanho Estimado:** ~100 bytes por bloco.
- **Frequência de Leitura/Escrita:** Alta frequência de leitura e escrita, especialmente durante a geração e manipulação de chunks.

### 2. Chunks
- **Tipo de Dado:** Conjunto de blocos voxel organizados em uma estrutura de chunk.
- **Tamanho Estimado:** Varia conforme o tamanho do chunk (ex: 16x16x16 blocos = 4096 blocos), aproximadamente 400KB por chunk.
- **Frequência de Leitura/Escrita:** Alta frequência de leitura, moderada frequência de escrita durante a geração ou modificação de chunks.

### 3. Configurações de Áudio
- **Tipo de Dado:** Parâmetros de configuração de áudio (ex: volume, codec).
- **Tamanho Estimado:** ~100 bytes.
- **Frequência de Leitura/Escrita:** Baixa frequência de leitura e escrita, principalmente durante a inicialização e quando o usuário ajusta as configurações.

### 4. Metadados de Usuário
- **Tipo de Dado:** Informações do usuário (ex: preferências, progresso).
- **Tamanho Estimado:** ~1KB.
- **Frequência de Leitura/Escrita:** Moderada frequência de leitura e escrita, especialmente quando o usuário interage com o jogo.

## Análise de Armazenamento

### KV (Key-Value Store)
- **Vantagens:** Acesso rápido, simplicidade.
- **Desvantagens:** Limitações em consultas complexas.
- **Uso Sugerido:** Configurações de áudio, metadados de usuário.

### R2 (Object Storage)
- **Vantagens:** Escalável, adequado para grandes volumes de dados.
- **Desvantagens:** Latência potencialmente maior.
- **Uso Sugerido:** Chunks, especialmente se o tamanho dos chunks for grande.

### D1 (Database)
- **Vantagens:** Suporte a consultas complexas, integridade de dados.
- **Desvantagens:** Pode ser mais lento que KV para acessos simples.
- **Uso Sugerido:** Blocos voxel, se necessário manter relações complexas entre eles.

## Conclusão

Com base na análise, sugere-se:
- Utilizar KV para configurações de áudio e metadados de usuário devido à sua simplicidade e acesso rápido.
- Utilizar R2 para armazenamento de chunks, aproveitando sua escalabilidade para grandes volumes de dados.
- Avaliar a necessidade de utilizar D1 para blocos voxel, considerando a complexidade das relações entre os dados e a necessidade de consultas complexas.

