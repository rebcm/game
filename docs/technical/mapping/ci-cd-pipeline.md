# Mapeamento Técnico do Pipeline CI/CD

## Introdução

Este documento visa mapear as ferramentas de CI/CD utilizadas no projeto `rebcm/game`, detalhando os triggers de execução, horários programados (cron) e a sequência exata de etapas do pipeline.

## Ferramentas de CI/CD Utilizadas

O projeto utiliza GitHub Actions como ferramenta de CI/CD.

## Pipelines Configurados

Os pipelines estão configurados em `.github/workflows/`. Abaixo, listamos os principais pipelines e suas funcionalidades:

### 1. `ci-cd.yml`

- **Trigger:** `push` na branch principal.
- **Etapas:**
  1. Configuração do ambiente.
  2. Execução de testes.
  3. Build do projeto.
  4. Deploy.

### 2. `flutter-ci-cd.yml`

- **Trigger:** `push` na branch principal.
- **Etapas:**
  1. Configuração do ambiente Flutter.
  2. Execução de testes Flutter.
  3. Build do projeto Flutter.

### 3. `build.yml` e `build-web.yml`

- **Trigger:** `push` na branch principal.
- **Etapas:**
  1. Build do projeto para diferentes plataformas.

### 4. `deploy.yml` e `deploy-web.yml`

- **Trigger:** Após o build bem-sucedido.
- **Etapas:**
  1. Deploy do projeto para as respectivas plataformas.

## Horários Programados (Cron)

Não há jobs agendados por cron identificados nos arquivos de configuração.

## Sequência Exata de Etapas do Pipeline

1. Configuração do ambiente e dependências.
2. Execução de testes unitários e de integração.
3. Build do projeto.
4. Deploy para as plataformas configuradas.

## Conclusão

O pipeline CI/CD do projeto `rebcm/game` é robusto e cobre as etapas essenciais de teste, build e deploy. A utilização de GitHub Actions facilita a integração com o repositório GitHub.
