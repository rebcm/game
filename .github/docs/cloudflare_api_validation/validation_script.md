# Validação do Token da API Cloudflare

## Introdução

Este guia visa validar a configuração do token da API Cloudflare para o projeto Rebeca Game.

## Pré-requisitos

1. Ter o Flutter instalado na versão especificada no `pubspec.yaml`.
2. Possuir o token da API Cloudflare configurado corretamente.

## Passos para Validação

1. Execute o comando `flutter pub get` para garantir que todas as dependências estejam atualizadas.
2. Configure o token da API Cloudflare seguindo as instruções no arquivo `.env.example`.
3. Renomeie o arquivo `.env.example` para `.env` e preencha o campo `CLOUDFLARE_API_TOKEN` com o token gerado.
4. Execute o comando `dart run build_runner build --delete-conflicting-outputs` para garantir que os arquivos gerados estejam atualizados.
5. Execute o pipeline de CI/CD para validar a configuração.

## Critérios de Aceitação

- O pipeline de CI/CD deve completar sem erros 403.
- A aplicação deve funcionar corretamente após a configuração do token.

## Referências

- [Documentação da Cloudflare](https://developers.cloudflare.com/api/)
{"pt-BR": "Tradução para pt-BR"}
