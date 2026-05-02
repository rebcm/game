# Matriz de Secrets

Este documento lista todas as chaves de API e variáveis de ambiente necessárias para o deploy no Cloudflare Pages.

## Variáveis de Ambiente

As seguintes variáveis de ambiente são necessárias para o deploy:

| Nome | Descrição | Exemplo |
| --- | --- | --- |
| CLOUDFLARE_API_TOKEN | Token de API do Cloudflare | xxxxxxxxxxxxxxxxxxxx |
| CLOUDFLARE_ACCOUNT_ID | ID da conta do Cloudflare | xxxxxxxxxxxxxxxxxxxx |
| CLOUDFLARE_PROJECT_NAME | Nome do projeto no Cloudflare Pages | rebcm-game |

## Chaves de API

As seguintes chaves de API são utilizadas no projeto:

| Nome | Descrição | Exemplo |
| --- | --- | --- |
| API_KEY_1 | Chave de API 1 | xxxxxxxxxxxxxxxxxxxx |
| API_KEY_2 | Chave de API 2 | xxxxxxxxxxxxxxxxxxxx |

## Configuração no .env

O arquivo `.env` deve conter as seguintes variáveis:

```makefile
CLOUDFLARE_API_TOKEN=xxxxxxxxxxxxxxxxxxxx
CLOUDFLARE_ACCOUNT_ID=xxxxxxxxxxxxxxxxxxxx
CLOUDFLARE_PROJECT_NAME=rebcm-game
```

## Observações

* Certifique-se de manter as chaves de API e variáveis de ambiente seguras e não commitá-las ao repositório.
* Utilize o arquivo `.env` para armazenar as variáveis de ambiente localmente.
