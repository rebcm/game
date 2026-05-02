# Secrets Necessárias para CI/CD

Este documento lista as secrets necessárias para a configuração do ambiente de CI/CD do projeto rebcm/game.

## Secrets Obrigatórias

* `CLOUDFLARE_API_TOKEN`: Token de API para autenticação no Cloudflare.
* `CLOUDFLARE_ACCOUNT_ID`: ID da conta Cloudflare.

## Configuração

Para configurar essas secrets no ambiente de CI/CD, siga os passos abaixo:

1. Acesse as configurações do seu repositório no GitHub.
2. Navegue até "Actions" > "Secrets".
3. Adicione as secrets `CLOUDFLARE_API_TOKEN` e `CLOUDFLARE_ACCOUNT_ID` com os valores correspondentes.

## Uso

Essas secrets são utilizadas nos workflows de CI/CD para autenticação e configuração do Cloudflare.
