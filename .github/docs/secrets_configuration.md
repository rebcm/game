# Configuração de Secrets

## Introdução

Este documento descreve como configurar os secrets necessários para o funcionamento do CI/CD do projeto.

## Secrets Necessários

- `CLOUDFLARE_API_TOKEN`
- `CLOUDFLARE_ACCOUNT_ID`

## Configuração

1. Vá para as configurações do repositório no GitHub.
2. Clique em "Actions" e depois em "Secrets".
3. Adicione os secrets `CLOUDFLARE_API_TOKEN` e `CLOUDFLARE_ACCOUNT_ID` com os valores correspondentes.

## Uso

Os secrets são usados no workflow `configure_secrets.yml` para autenticar o Wrangler no CI/CD.
