# Secrets Necessárias para CI/CD

Este documento lista as secrets necessárias para a configuração do ambiente de CI/CD do projeto rebcm/game.

## Secrets Obrigatórias

* `CLOUDFLARE_API_TOKEN`: Token de API da Cloudflare para autenticação e autorização.
* `CLOUDFLARE_ACCOUNT_ID`: ID da conta da Cloudflare para identificação da conta.

## Configuração

Para configurar essas secrets no ambiente de CI/CD, siga os passos abaixo:

1. Acesse as configurações do seu repositório no GitHub.
2. Navegue até a seção "Actions" e clique em "Secrets".
3. Adicione as secrets `CLOUDFLARE_API_TOKEN` e `CLOUDFLARE_ACCOUNT_ID` com os valores correspondentes.

## Uso

Essas secrets são utilizadas nos workflows de CI/CD para autenticação e autorização com a Cloudflare.
