# Procedimento de Deploy

## Introdução
Este documento detalha o processo de deploy do jogo Rebeca, construído com Flutter, e o procedimento para reverter versões em caso de falha crítica.

## Pré-requisitos
- Ter o Flutter instalado e configurado corretamente.
- Ter acesso ao repositório do projeto.
- Ter as dependências do projeto instaladas (`flutter pub get`).

## Processo de Deploy
1. **Build do Projeto**: Execute o comando `flutter build web` para compilar o projeto para a web.
2. **Deploy para Cloudflare Pages**: Utilize o GitHub Actions configurado em `.github/workflows/deploy-cloudflare-pages.yml` para automatizar o deploy.
   - O workflow é acionado automaticamente ao push na branch principal.
   - Verifique o status do deploy no painel do GitHub Actions.

## Rollback de Versão
1. **Identifique a Versão Anterior**: Verifique o histórico de commits e identifique a versão anterior estável.
2. **Checkout da Versão Anterior**: Faça checkout da versão anterior utilizando `git checkout <hash-do-commit>`.
3. **Re-deploy da Versão Anterior**: Execute novamente o workflow de deploy para a versão anterior.

## Considerações Finais
- Certifique-se de que todos os testes passem antes de realizar o deploy.
- Monitore o desempenho do jogo após o deploy para identificar possíveis problemas.
