# Especificação de Payload

## Introdução

Este documento define a estrutura do frame binário utilizado para comunicação no jogo Rebeca. A especificação inclui headers de compressão e checksums para garantir a integridade dos dados.

## Estrutura do Frame Binário

O frame binário é composto pelas seguintes seções:

1. **Header**
   - `magic_number` (4 bytes): Número mágico para identificar o início do frame.
   - `payload_size` (4 bytes): Tamanho do payload em bytes.
   - `compression_flag` (1 byte): Flag indicando se o payload está comprimido.

2. **Payload**
   - Dados serializados do jogo, que podem incluir informações de estado, ações do jogador, etc.

3. **Checksum**
   - `checksum` (4 bytes): Checksum CRC32 do payload para verificar integridade.

## Compressão

- Quando `compression_flag` é 1, o payload está comprimido utilizando o algoritmo [nome do algoritmo, e.g., zlib].
- Quando `compression_flag` é 0, o payload não está comprimido.

## Exemplo de Estrutura

| Offset | Tamanho | Descrição            |
|--------|---------|----------------------|
| 0      | 4       | magic_number         |
| 4      | 4       | payload_size         |
| 8      | 1       | compression_flag     |
| 9      | variável| payload              |
| ?      | 4       | checksum             |

## Implementação

A implementação deve seguir as seguintes diretrizes:
- Utilizar a biblioteca `crypto` para cálculo de checksum CRC32.
- Utilizar a biblioteca `archive` para compressão, se aplicável.

## Testes

Devem ser implementados testes para verificar a correta serialização e deserialização do frame binário, bem como a integridade dos dados através do checksum.
