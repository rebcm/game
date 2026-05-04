# Versionamento de Documentação

## Introdução

Este documento define a estratégia de versionamento da documentação do projeto Rebeca.

## Motivação

Com o avanço das versões do aplicativo, é crucial manter a documentação atualizada e vinculada às respectivas versões do app para evitar confusão em versões legadas.

## Estratégia de Versionamento

1. **Versionamento Semântico**: A documentação será versionada seguindo o mesmo padrão semântico utilizado para as versões do aplicativo (ex: v1.0, v1.1).
2. **Branches de Documentação**: Para cada versão do aplicativo, será criada uma branch específica no repositório para armazenar a documentação correspondente.
3. **Tags de Versão**: As tags de versão serão utilizadas para marcar os pontos de release tanto do aplicativo quanto da documentação.
4. **Documentação Atual**: A branch `main` ou `master` do repositório sempre conterá a documentação mais atualizada, correspondente à versão mais recente do aplicativo.

## Implementação

- Criar branches específicas para a documentação de cada versão releaseada (ex: `docs/v1.0`, `docs/v1.1`).
- Utilizar tags para marcar as versões releaseadas da documentação (ex: `v1.0-docs`, `v1.1-docs`).
- Manter a documentação na branch principal (`main` ou `master`) atualizada para a próxima versão do aplicativo.

## Fluxo de Trabalho

1. Ao iniciar o desenvolvimento de uma nova versão do aplicativo, criar uma branch de desenvolvimento.
2. Atualizar a documentação conforme necessário durante o desenvolvimento.
3. Ao finalizar o desenvolvimento e preparar o release, criar uma branch específica para a documentação daquela versão.
4. Marcar a documentação com a tag correspondente à versão do release.
5. Manter a documentação na branch principal atualizada para a próxima versão.

## Conclusão

A implementação desta estratégia de versionamento garantirá que a documentação permaneça organizada e facilmente acessível para qualquer versão do aplicativo, facilitando a manutenção e o entendimento do projeto ao longo do tempo.
{"pt-BR": "Tradução para pt-BR"}
