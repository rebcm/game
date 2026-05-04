# Wiki Técnico do Projeto Rebeca

## Introdução

Este documento visa consolidar todas as informações relevantes sobre o projeto Rebeca, incluindo sua arquitetura, fluxos de funcionamento e critérios de aceitação.

## Estrutura do Projeto

O projeto Rebeca é um jogo desenvolvido em Flutter, utilizando a linguagem Dart. A estrutura do projeto segue as melhores práticas de organização e modularidade.

### Dependências

As dependências do projeto estão listadas no arquivo `pubspec.yaml`. As principais dependências incluem:

- `provider`: Gerenciamento de estado
- `archive`: Manipulação de arquivos compactados
- `http`: Requisições HTTP
- `audioplayers`: Reprodução de áudio
- `permission_handler`: Gerenciamento de permissões
- `lottie`: Animações
- `rive`: Animações vetoriais

## Fluxo de Funcionamento

O jogo Rebeca opera em um modo criativo puro, sem elementos de sobrevivência ou NPCs. O jogador pode interagir com o ambiente voxel, criando e modificando estruturas.

### Inicialização

Ao iniciar o jogo, o sistema carrega as configurações e inicializa os recursos necessários.

### Loop Principal

O loop principal do jogo é responsável por:

1. Processar entradas do usuário
2. Atualizar o estado do jogo
3. Renderizar o ambiente voxel

## Critérios de Aceitação

Os critérios de aceitação para o projeto Rebeca estão definidos em vários documentos localizados na pasta `.github/docs`. Alguns dos critérios incluem:

- Critérios de aceitação para testes de integração
- Critérios de aceitação para performance
- Critérios de aceitação para segurança da API

## Diagramas de Fluxo

Os diagramas de fluxo relevantes para o entendimento do funcionamento do jogo estão disponíveis na pasta `.github/docs`.

## Conclusão

Este wiki técnico serve como um guia abrangente para entender a estrutura, o funcionamento e os critérios de aceitação do projeto Rebeca. Ele deve ser consultado por desenvolvedores e colaboradores para garantir a consistência e a qualidade do projeto.
