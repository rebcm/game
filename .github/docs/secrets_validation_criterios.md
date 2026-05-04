# Critérios de Aceitação para Validação de Secrets

## Introdução

Este documento define os critérios de aceitação para a validação de secrets no projeto.

## Critérios

1. As chaves de assinatura (keystores/certs) devem ser injetadas via Secrets do repositório.
2. As chaves de assinatura não devem ser hardcoded no pipeline.
3. O script de validação de secrets deve verificar se as variáveis de ambiente necessárias estão setadas corretamente.

## Validação

O script `validate_secrets.sh` deve ser executado durante o pipeline de CI para validar as chaves de assinatura.
{"pt-BR": "Tradução para pt-BR"}
