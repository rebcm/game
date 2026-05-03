# Validação de Token Cloudflare

## Introdução

Este documento descreve o processo de validação do token Cloudflare utilizado no deploy do aplicativo Flutter.

## Script de Validação

O script `validate_token.sh` localizado em `.github/scripts/ci_validation/token_validation` é responsável por validar o token Cloudflare.

### Parâmetros

- `TOKEN`: O token Cloudflare a ser validado.
- `ZONE_ID`: O ID da zona Cloudflare.

### Funcionamento

O script utiliza a API do Cloudflare para verificar as permissões do token fornecido. Ele verifica se o token possui as permissões `Zone.DNS` e `Zone.Settings`.

### Retorno

- `0`: Token válido.
- `1`: Token inválido ou sem as permissões necessárias.
