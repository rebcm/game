# Matriz de Permissões Mínimas para Cloudflare Pages

Este documento define a matriz de permissões mínimas necessárias para cada ação do pipeline Cloudflare Pages, seguindo o Princípio do Menor Privilégio para evitar brechas de segurança.

## Introdução

O pipeline Cloudflare Pages é responsável por automatizar o processo de deploy do jogo Construção Criativa da Rebeca. Para garantir a segurança e integridade do processo, é crucial definir as permissões mínimas necessárias para cada ação realizada pelo pipeline.

## Matriz de Permissões

| Ação | Permissão Mínima Necessária |
| --- | --- |
| Deploy | `pages:write` |
| Build | `pages:read` |
| Acesso aos Secrets | `secret:read` |

## Justificativa

- **Deploy**: A permissão `pages:write` é necessária para realizar o deploy do jogo no Cloudflare Pages.
- **Build**: A permissão `pages:read` é necessária para acessar as configurações do projeto Cloudflare Pages durante o processo de build.
- **Acesso aos Secrets**: A permissão `secret:read` é necessária para acessar os secrets configurados no repositório, que são utilizados durante o processo de build e deploy.

## Conclusão

A implementação desta matriz de permissões mínimas garantirá que o pipeline Cloudflare Pages opere de acordo com o Princípio do Menor Privilégio, minimizando o risco de brechas de segurança.

