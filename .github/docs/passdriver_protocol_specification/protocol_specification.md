# Protocolo de Payload do Passdriver

## Visão Geral

Este documento detalha a estrutura do frame binário, headers de compressão e versionamento do protocolo utilizado pelo Passdriver para garantir a compatibilidade entre cliente e servidor.

## Estrutura do Frame Binário

O frame binário é composto pelas seguintes seções:

1. **Cabeçalho**: Contém informações de versionamento e compressão.
   - **Versão do Protocolo** (2 bytes): Identifica a versão do protocolo utilizado.
   - **Tipo de Compressão** (1 byte): Indica o algoritmo de compressão usado.
   - **Tamanho do Payload** (4 bytes): Tamanho do payload após descompressão.

2. **Payload**: Dados serializados e possivelmente comprimidos.

## Versionamento do Protocolo

- A versão do protocolo é representada por um número de 2 bytes, permitindo até 65536 versões diferentes.
- A versão atual do protocolo é `0x0001`.

## Compressão

- O tipo de compressão é indicado por um byte, suportando até 256 algoritmos diferentes.
- Atualmente, suportamos:
  - `0x00`: Sem compressão.
  - `0x01`: Compressão LZ4.

## Exemplo de Frame Binário

| Offset | Tamanho | Descrição |
|--------|---------|-----------|
| 0      | 2       | Versão do Protocolo |
| 2      | 1       | Tipo de Compressão |
| 3      | 4       | Tamanho do Payload |
| 7      | Variável | Payload |

## Implementação

A implementação do protocolo deve seguir as especificações acima, garantindo que tanto o cliente quanto o servidor possam se comunicar de forma eficaz e segura.

{"pt-BR": "Tradução para pt-BR"}
