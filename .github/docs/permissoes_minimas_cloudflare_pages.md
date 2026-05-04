# Matriz de Permissões Mínimas para Cloudflare Pages

Este documento define a matriz de permissões mínimas necessárias para cada ação do pipeline Cloudflare Pages, seguindo o Princípio do Menor Privilégio para evitar brechas de segurança.

## Introdução

O Princípio do Menor Privilégio é uma prática de segurança que recomenda conceder as menores permissões necessárias para realizar uma tarefa. Isso minimiza o risco de danos em caso de comprometimento de credenciais ou uso indevido.

## Matriz de Permissões

| Ação | Permissão Necessária | Justificativa |
| --- | --- | --- |
| Deploy | `Cloudflare Pages: Editar` | Necessário para realizar o deploy do site. |
| Build | `Cloudflare Pages: Editar` | Necessário para realizar a compilação do site. |
| Acesso ao Repositório | `Leitura` | Necessário para acessar o código-fonte do projeto. |

## Implementação

Para implementar essas permissões, siga os passos abaixo:

1. Acesse o painel de controle do Cloudflare.
2. Navegue até a seção de configurações do seu site Pages.
3. Ajuste as permissões de acordo com a matriz acima.

## Conclusão

A implementação da matriz de permissões mínimas para o pipeline Cloudflare Pages é crucial para manter a segurança do projeto. Esta documentação serve como referência para futuras manutenções e auditorias.
{"pt-BR": "Tradução para pt-BR"}
