# Critérios de Aceitação para Validação de Secrets

## Introdução

Este documento define os critérios de aceitação para a validação de secrets no pipeline de CI/CD.

## Critérios

1. O script de validação deve verificar a presença do `CLOUDFLARE_API_TOKEN` no arquivo `.env`.
2. O script de validação deve verificar a validade do `CLOUDFLARE_API_TOKEN` usando a API da Cloudflare.
3. O script de validação deve retornar um código de saída não-zero se o token estiver ausente ou inválido.

## Conclusão

A validação de secrets é uma etapa crítica no pipeline de CI/CD. Este documento define os critérios de aceitação para garantir que a validação seja realizada corretamente.
