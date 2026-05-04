# Mapeamento de Segredos do Backend

Este documento visa listar todas as chaves de API, tokens de autenticação e segredos de banco de dados utilizados no código do Worker para configuração no `wrangler.toml`.

## Segredos Identificados

| Nome do Segredo | Localização no Código | Descrição |
|------------------|------------------------|-----------|
|                  |                        |           |

## Passos para Identificação

1. Verificar arquivos de configuração (e.g., `.env`, `pubspec.yaml`)
2. Revisar código Dart para usos de `dotenv` ou variáveis de ambiente
3. Identificar chamadas de API e respectivos tokens ou chaves

## Como Atualizar o `wrangler.toml`

1. Adicionar os segredos identificados na seção `[vars]` do `wrangler.toml`
2. Utilizar a CLI do Wrangler para configurar os segredos: `wrangler secret put <nome_do_secredo>`

{"pt-BR": "Tradução para pt-BR"}
