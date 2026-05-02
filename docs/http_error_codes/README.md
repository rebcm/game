# Mapeamento de Códigos de Erro HTTP Esperados

Este documento mapeia os códigos de erro HTTP esperados pelo pipeline do projeto Rebeca e define as mensagens de erro finais para o desenvolvedor.

## Códigos de Erro HTTP

| Código HTTP | Descrição | Mensagem de Erro |
| --- | --- | --- |
| 401 | Não autorizado | "Erro de autenticação: verifique suas credenciais." |
| 403 | Proibido | "Acesso negado: você não tem permissão para realizar esta ação." |
| 507 | Armazenamento insuficiente | "Erro de armazenamento: não há espaço suficiente para realizar a operação." |

## Implementação

O pipeline deve capturar os códigos HTTP acima e exibir as mensagens de erro correspondentes ao desenvolvedor.

## Referências

- [Lista de códigos de status HTTP](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)
