# Validação de Token Cloudflare

## Introdução

Este documento descreve o processo de validação de token Cloudflare utilizado no projeto.

## Script de Validação

O script `validate_cloudflare_token.sh` é responsável por validar se o token fornecido possui as permissões necessárias para o deploy do aplicativo.

### Permissões Necessárias

- `#zone:$ZONE_ID:read`
- `#zone:$ZONE_ID:dns:edit`
- `#zone:$ZONE_ID:settings:edit`

### Uso
