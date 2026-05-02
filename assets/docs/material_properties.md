# Tabela de Propriedades dos Materiais

## Introdução

Este documento define as propriedades de fricção e elasticidade (bounce) para diferentes superfícies no jogo, garantindo consistência no comportamento físico dos objetos.

## Tabela de Materiais

| Material     | Fricção | Bounce |
|--------------|---------|--------|
| Bloco Terra  | 0.8     | 0.1    |
| Bloco Água   | 0.2     | 0.7    |
| Bloco Gelo   | 0.1     | 0.9    |
| Bloco Madeira| 0.6     | 0.3    |
| Bloco Metal  | 0.4     | 0.5    |

## Explicação das Propriedades

- **Fricção**: Determina a resistência ao movimento entre superfícies. Valores mais altos significam mais atrito.
- **Bounce**: Representa a elasticidade de uma colisão. Valores mais próximos de 1 significam que o objeto quica mais.

## Implementação

As propriedades definidas nesta tabela devem ser implementadas no código do jogo, associando cada tipo de bloco às suas respectivas características físicas.

