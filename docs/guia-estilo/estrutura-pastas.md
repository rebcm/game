# Guia de Estilo de Pastas

Este documento descreve a estrutura de pastas adotada no projeto Flutter de blocos voxel modo criativo.

## Camadas do Projeto

O projeto é organizado em três camadas principais: Data, Domain e Presentation.

### Data

A camada Data é responsável por gerenciar os dados do aplicativo. Ela inclui modelos de dados, repositórios e serviços de dados.

*   `lib/data/models`: Modelos de dados utilizados no aplicativo.
*   `lib/data/repositories`: Repositórios que encapsulam a lógica de acesso a dados.
*   `lib/data/services`: Serviços que fornecem dados ao aplicativo.

### Domain

A camada Domain contém a lógica de negócios do aplicativo. Ela inclui casos de uso e interfaces para repositórios.

*   `lib/domain/usecases`: Casos de uso que definem as ações que podem ser realizadas no aplicativo.
*   `lib/domain/repositories`: Interfaces para repositórios que são utilizados pelos casos de uso.

### Presentation

A camada Presentation é responsável pela interface do usuário e pela interação com o usuário. Ela inclui widgets, telas e controladores.

*   `lib/presentation/widgets`: Widgets personalizados utilizados no aplicativo.
*   `lib/presentation/screens`: Telas do aplicativo.
*   `lib/presentation/controllers`: Controladores que gerenciam o estado das telas.

## Outros Diretórios Importantes

*   `lib/utils`: Funções utilitárias que são utilizadas em todo o aplicativo.
*   `test`: Testes unitários e de integração para o aplicativo.

