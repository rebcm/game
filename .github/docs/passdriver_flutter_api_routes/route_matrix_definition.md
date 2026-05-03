# Definição de Matriz de Rotas

## Introdução

Este documento define a matriz de rotas da API utilizada pelo jogo "Construção Criativa da Rebeca" em Flutter, bem como os triggers de CI/CD configurados para os ambientes de staging e production.

## Rotas da API

| Rota | Método | Descrição | Ambiente |
| --- | --- | --- | --- |
| /api/v1/healthcheck | GET | Verifica a saúde da API | Staging, Production |
| /api/v1/config | GET | Obtém configurações do jogo | Staging, Production |

## Triggers de CI/CD

### Ambiente de Staging

- Trigger: `push` na branch `staging`
- Ações:
  - Build e deploy do jogo
  - Execução de testes de integração

### Ambiente de Production

- Trigger: `push` na branch `main`
- Ações:
  - Build e deploy do jogo
  - Execução de testes de integração

## Configuração de Variáveis de Ambiente

As variáveis de ambiente são configuradas através do arquivo `.env`. Veja `.env.example` para mais detalhes.

## Conclusão

Esta matriz de rotas e triggers de CI/CD assegura que o jogo "Construção Criativa da Rebeca" seja entregue de forma consistente e confiável nos ambientes de staging e production.
