# Validação do Token Cloudflare

## Introdução

Este documento descreve o processo de validação do token Cloudflare utilizado no projeto.

## Script de Validação

O script `validate_cloudflare_token.sh` localizado em `.github/scripts/validate_cloudflare_token` é responsável por validar o token Cloudflare.

### Funcionamento

1. Verifica se as variáveis de ambiente `CLOUDFLARE_API_TOKEN` e `CLOUDFLARE_ZONE_ID` estão definidas.
2. Realiza uma requisição GET para a API do Cloudflare usando o token e o zone ID fornecidos.
3. Verifica se a resposta da API indica sucesso.

### Uso

O script deve ser executado em um ambiente onde as variáveis de ambiente `CLOUDFLARE_API_TOKEN` e `CLOUDFLARE_ZONE_ID` estejam configuradas.
{"pt-BR": "Tradução para pt-BR"}
