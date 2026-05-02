# Mapeamento Técnico do Pipeline CI/CD

## Introdução

Este documento fornece um mapeamento detalhado do pipeline CI/CD utilizado no projeto rebcm/game. O pipeline é responsável por automatizar processos de build, teste e deploy do jogo.

## Ferramentas de CI/CD Utilizadas

* GitHub Actions

## Triggers de Execução

O pipeline é acionado nos seguintes eventos:
- Push para a branch main
- Pull requests para a branch main

## Horários Programados (Cron)

Não há horários programados configurados para o pipeline.

## Sequência de Etapas do Pipeline

1. **Configuração de Secrets**: Configura as variáveis de ambiente necessárias para o pipeline.
   - Arquivo: `.github/workflows/configure-secrets.yml`

2. **Build do Projeto Flutter**:
   - Arquivo: `.github/workflows/flutter-build.yml`

3. **Testes de Integração**:
   - Arquivo: `.github/workflows/integracao_test.yml`

4. **Deploy para Cloudflare Pages**:
   - Arquivo: `.github/workflows/deploy-cloudflare-pages.yml`

5. **Limpeza de Artefatos**:
   - Arquivo: `.github/workflows/cleanup.yml`

## Observações

O pipeline é definido em vários arquivos YAML dentro da pasta `.github/workflows`. Cada arquivo representa uma etapa ou um conjunto de etapas relacionadas no processo de CI/CD.

## Conclusão

O pipeline CI/CD do projeto rebcm/game é robusto e cobre as principais etapas de build, teste e deploy. A utilização de GitHub Actions facilita a integração com o repositório e permite uma configuração flexível das etapas do pipeline.
