# Configuração de Recuperação de Chaves

## Visão Geral

Este documento descreve a configuração para recuperação de chaves do projeto.

## Variáveis de Ambiente

- `KEYSTORE_BASE64`: Chave Base64 codificada do keystore.

## Fluxo de Recuperação

1. A chave codificada em Base64 é armazenada como um segredo no GitHub.
2. Durante o processo de CI/CD, o script `recover_key.sh` é executado.
3. O script decodifica a chave Base64 e salva-a como um arquivo `keystore.jks`.

## Referências

- [Script de Recuperação de Chaves](../scripts/key_recovery/recover_key.sh)
