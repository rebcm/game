# Mapeamento de Entidades e Volumetria de Dados

## Introdução

Este documento apresenta o mapeamento das entidades utilizadas no projeto `rebcm/game`, definindo o tipo de dado, tamanho estimado e frequência de leitura/escrita para justificar a escolha entre KV, R2 ou D1 para armazenamento.

## Entidades do Projeto

### 1. Blocos Voxel

- **Tipo de Dado:** Estrutura de dados representando um bloco voxel (ex: tipo de bloco, posição, estado)
- **Tamanho Estimado:** ~100 bytes por bloco
- **Frequência de Leitura/Escrita:** Alta frequência de leitura e escrita, especialmente durante a geração e manipulação de chunks

### 2. Chunks

- **Tipo de Dado:** Conjunto de blocos voxel organizados em uma estrutura de chunk
- **Tamanho Estimado:** Varia de acordo com o tamanho do chunk (ex: 16x16x16 blocos = 4096 blocos \* ~100 bytes = ~409.6 KB)
- **Frequência de Leitura/Escrita:** Alta frequência de leitura, moderada frequência de escrita durante a geração e atualização de chunks

### 3. Configurações de Áudio

- **Tipo de Dado:** Parâmetros de configuração de áudio (ex: volume, codec, estado de reprodução)
- **Tamanho Estimado:** ~100-500 bytes
- **Frequência de Leitura/Escrita:** Moderada frequência de leitura e escrita, especialmente durante a inicialização e mudanças de configuração

### 4. Metadados de Assets

- **Tipo de Dado:** Informações sobre assets (ex: caminhos de arquivos, dimensões, formatos)
- **Tamanho Estimado:** ~1-10 KB por asset
- **Frequência de Leitura/Escrita:** Baixa frequência de escrita, alta frequência de leitura durante a inicialização e carregamento de assets

## Justificativa de Armazenamento

- **Blocos Voxel e Chunks:** Devido à alta frequência de leitura e escrita, e ao tamanho variável dos dados, sugere-se o uso de um armazenamento KV (Key-Value) para esses dados, pois oferece alta performance para operações de leitura e escrita.
- **Configurações de Áudio e Metadados de Assets:** Para esses dados, que têm menor frequência de escrita e tamanho relativamente pequeno, um armazenamento mais simples como SharedPreferences (para configurações de áudio) e um sistema de arquivos ou armazenamento local (para metadados de assets) podem ser suficientes.

## Conclusão

O mapeamento das entidades e a análise da volumetria de dados sugerem o uso de diferentes estratégias de armazenamento para atender às necessidades específicas de cada tipo de dado no projeto `rebcm/game`. A escolha entre KV, R2 ou D1 deve ser baseada nas características de cada tipo de dado e nas necessidades de performance do jogo.
