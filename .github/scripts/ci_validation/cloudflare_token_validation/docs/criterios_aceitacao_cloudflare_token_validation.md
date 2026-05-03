# Critérios de Aceitação para Validação de Token Cloudflare

## Introdução

Este documento define os critérios de aceitação para o script de validação de token Cloudflare.

## Critérios

1. O script deve verificar se o token Cloudflare fornecido possui as permissões Zone.DNS e Zone.Settings.
2. O script deve retornar um erro se o token for inválido, expirado ou não possuir as permissões necessárias.
3. O script deve ser executado antes do deploy do app Flutter.

## Conclusão

O script de validação de token Cloudflare deve garantir que o token fornecido seja válido e possua as permissões necessárias para o deploy do app Flutter.
