# Especificação de Payload

## Introdução

Este documento define a estrutura do frame binário utilizado para a transferência de dados no jogo Rebeca.

## Estrutura do Frame Binário

O frame binário é composto pelas seguintes seções:

1. **Header**: Informações de controle, incluindo compressão e checksum.
2. **Payload**: Dados do jogo, como estado do mundo ou comandos do jogador.

### Header

- **Compressão (1 byte)**: Indica se o payload está comprimido (0x01) ou não (0x00).
- **Checksum (4 bytes)**: Checksum CRC32 do payload.

### Payload

- **Dados do Jogo**: Serialização dos dados do jogo em formato binário.

## Exemplo de Estrutura

| Offset | Tamanho | Descrição            |
|--------|---------|----------------------|
| 0      | 1       | Flag de Compressão   |
| 1      | 4       | Checksum CRC32       |
| 5      | N       | Dados do Jogo        |

## Implementação

A implementação deve seguir as especificações acima, garantindo que o frame binário seja corretamente montado e interpretado.

