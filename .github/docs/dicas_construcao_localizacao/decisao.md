# Definição de Localização de Dicas de Construção

## Introdução

Este documento define a localização das dicas de construção dentro do jogo Rebeca.

## Opções Consideradas

1. **Arquivos Markdown no Repositório**: Armazenar as dicas em arquivos Markdown dentro do repositório do projeto.
2. **Tooltips dentro da Interface Flutter**: Implementar as dicas como Tooltips diretamente na interface do usuário utilizando Flutter.
3. **Portal de Ajuda Externo**: Criar um portal de ajuda externo ao jogo onde as dicas estarão disponíveis.

## Decisão

As dicas de construção serão implementadas via arquivos Markdown no repositório.

## Justificativa

1. **Manutenção**: Facilita a manutenção e atualização das dicas sem necessidade de alterar o código do jogo.
2. **Versionamento**: Permite que as dicas sejam versionadas junto com o código do jogo, garantindo que as dicas corretas sejam exibidas para cada versão.
3. **Acessibilidade**: As dicas podem ser facilmente acessadas e visualizadas dentro do repositório ou através de uma interface no jogo que leia os arquivos Markdown.

## Implementação

1. Criar uma pasta dentro de `.github/docs` para armazenar os arquivos Markdown das dicas.
2. Desenvolver uma funcionalidade no jogo que leia e exiba as dicas dos arquivos Markdown.

## Tarefas Futuras

- Criar os arquivos Markdown com as dicas de construção.
- Implementar a funcionalidade no jogo para ler e exibir as dicas.
{"pt-BR": "Tradução para pt-BR"}
