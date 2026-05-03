# Guia de Estilo de Pastas

Este documento fornece uma visão geral da estrutura de pastas do projeto Flutter do jogo criativo de blocos voxel.

## Estrutura de Pastas

A estrutura de pastas do projeto é organizada da seguinte forma:

* `lib/`
  * `data/`: Camada de dados, responsável por armazenar e fornecer acesso aos dados do jogo.
  * `domain/`: Camada de domínio, responsável por definir as regras de negócios e entidades do jogo.
  * `presentation/`: Camada de apresentação, responsável por renderizar a interface do usuário do jogo.

## Mapeamento de Camadas para Pastas

A seguir, é apresentado o mapeamento das camadas para as pastas específicas do projeto:

| Camada | Pasta |
| --- | --- |
| Data | `lib/data/` |
| Domain | `lib/domain/` |
| Presentation | `lib/presentation/` |

## Convenções de Nomenclatura

As seguintes convenções de nomenclatura são adotadas no projeto:

* Pastas e arquivos são nomeados em minúsculas, com palavras separadas por sublinhados (`_`).
* Classes e variáveis são nomeadas seguindo as convenções do Dart.

## Exemplo de Estrutura de Pastas

A seguir, é apresentado um exemplo de estrutura de pastas para uma feature específica do jogo:

* `lib/`
  * `data/`
    * `models/`
    * `repositories/`
  * `domain/`
    * `entities/`
    * `usecases/`
  * `presentation/`
    * `screens/`
    * `widgets/`

