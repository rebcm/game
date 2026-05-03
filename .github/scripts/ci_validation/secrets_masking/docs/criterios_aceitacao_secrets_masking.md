# Critérios de Aceitação para Mascaramento de Secrets

## Critérios

1. O script `mask_secrets.sh` deve mascarar todos os valores sensíveis definidos no arquivo `.env`.
2. O script `mask_secrets.sh` deve ser executado no pipeline de CI.
3. Os valores sensíveis não devem aparecer nos logs do GitHub Actions.

## Verificação

1. Verificar se o script `mask_secrets.sh` está sendo executado no pipeline de CI.
2. Verificar se os valores sensíveis estão sendo mascarados nos logs do GitHub Actions.
