# Fluxo de CI/CD do Projeto Rebeca

## Introdução

Este documento descreve o fluxo de Continuous Integration e Continuous Deployment (CI/CD) do projeto Rebeca, um jogo de blocos voxel desenvolvido em Flutter.

## Fluxo de CI/CD

O fluxo de CI/CD é definido nos arquivos YAML dentro da pasta `.github/workflows`. Os principais fluxos são:

1. **Build e Testes**: `.github/workflows/build.yml` e `.github/workflows/flutter-ci-cd.yml`
   - Responsáveis por compilar o projeto e executar testes automatizados.

2. **Deploy**: `.github/workflows/deploy-cloudflare-pages.yml` e `.github/workflows/deploy-web.yml`
   - Responsáveis por fazer o deploy do jogo para as plataformas definidas.

## Passos do Fluxo

1. **Configuração de Secrets**: `.github/workflows/configure-secrets.yml`
   - Configura as variáveis de ambiente necessárias para o fluxo.

2. **Build do Projeto**: `.github/workflows/build.yml`
   - Compila o projeto Flutter.

3. **Testes Automatizados**: Vários arquivos dentro de `.github/workflows/`, como `animation_test.yml`, `audio_test.yml`, etc.
   - Executam diferentes tipos de testes, incluindo testes de unidade, integração e stress.

4. **Deploy**: `.github/workflows/deploy-cloudflare-pages.yml`
   - Faz o deploy do jogo para Cloudflare Pages.

## Hospedagem da Documentação

A documentação de CI/CD será hospedada no README do repositório, com links para os documentos detalhados dentro da pasta `docs/ci-cd`.

## Conclusão

O fluxo de CI/CD do projeto Rebeca é crucial para garantir a qualidade e a disponibilidade do jogo. Este documento serve como referência para entender como o processo é implementado e executado.
