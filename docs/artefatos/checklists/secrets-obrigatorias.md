# Secrets Obrigatórias para CI/CD

Este documento lista as secrets necessárias para a configuração do ambiente de CI/CD do projeto Rebeca.

## Lista de Secrets

* `CLOUDFLARE_API_TOKEN`: Token de API para autenticação no Cloudflare.
* `CLOUDFLARE_ACCOUNT_ID`: ID da conta Cloudflare.

## Configuração

Para configurar essas secrets, siga os passos abaixo:

1. Acesse o repositório no GitHub.
2. Vá para Settings > Actions > Secrets.
3. Adicione as secrets `CLOUDFLARE_API_TOKEN` e `CLOUDFLARE_ACCOUNT_ID` com os valores correspondentes.

## Validação

Após configurar as secrets, valide se o workflow de CI/CD está funcionando corretamente.
