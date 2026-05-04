# Rotação de Secrets do Cloudflare

## Introdução

Este documento descreve o processo de rotação dos secrets do Cloudflare utilizados no projeto.

## Passos para Rotação

1. Acesse o repositório no GitHub.
2. Vá para a seção de "Actions" e selecione o workflow "Configure Cloudflare Secrets".
3. Clique em "Run workflow" e preencha os campos com os novos valores para `CLOUDFLARE_API_TOKEN` e `CLOUDFLARE_ACCOUNT_ID`.

## Considerações

- Certifique-se de que os novos valores sejam válidos e tenham as permissões necessárias.
- Após a rotação, verifique se o workflow de CI/CD continua funcionando corretamente.
{"pt-BR": "Tradução para pt-BR"}
