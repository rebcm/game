# Documentação do Pipeline CI/CD

## Introdução

Este documento detalha o pipeline de CI/CD utilizado no projeto `rebcm/game`. O pipeline é responsável por automatizar o processo de build, teste e deploy do jogo.

## Ferramenta de CI/CD

A ferramenta de CI/CD utilizada é o GitHub Actions.

## Etapas do Pipeline

1. **Build**: Compila o código Flutter do jogo.
2. **Teste**: Executa os testes unitários e de integração do jogo.
3. **Deploy**: Realiza o deploy do jogo para a plataforma de destino.

## Gatilhos

O pipeline é acionado nos seguintes eventos:

* Push para a branch `main`
* Criação de pull requests para a branch `main`

## Horários

O pipeline é executado em tempo real, sem horários agendados.

## Configuração

A configuração do pipeline está definida no arquivo `.github/workflows/main.yml`.

## Detalhes Adicionais

* O pipeline utiliza a imagem `flutter:latest` para compilar e testar o código.
* O deploy é realizado utilizando a ação `flutter build` e `flutter deploy`.

