# Documentação do Pipeline de CI/CD

Este documento descreve as etapas do pipeline de CI/CD utilizado no projeto.

## Etapas do Pipeline

1. **Validação de Código**: Verifica se o código está de acordo com as regras de linting e se há erros de análise estática.
2. **Testes de Integração**: Executa os testes de integração definidos no projeto.
3. **Build e Release**: Compila o projeto e prepara o release para deploy.

## Scripts Utilizados

- `build_and_release.sh`: Script responsável por compilar o projeto e preparar o release.
- `validate_pipeline.sh`: Script que valida a execução do pipeline.

## Configuração

A configuração do pipeline é feita através do arquivo `.github/workflows/main.yml`.
