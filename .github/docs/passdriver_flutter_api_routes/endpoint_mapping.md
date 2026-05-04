# Mapeamento de Endpoints da API do Passdriver Flutter

## Visão Geral

Este documento fornece um mapeamento detalhado dos endpoints da API utilizados pelo módulo Passdriver Flutter no projeto Construção Criativa da Rebeca.

## Endpoints da API

### Autenticação

| Endpoint | Método | Descrição |
| --- | --- | --- |
| `/auth/login` | POST | Realiza login do usuário |
| `/auth/logout` | POST | Realiza logout do usuário |
| `/auth/refresh-token` | POST | Atualiza token de autenticação |

### Usuário

| Endpoint | Método | Descrição |
| --- | --- | --- |
| `/user/profile` | GET | Obtém perfil do usuário logado |
| `/user/profile` | PUT | Atualiza perfil do usuário logado |

### Jogo

| Endpoint | --- | --- |
| `/game/state` | GET | Obtém estado atual do jogo |
| `/game/actions` | POST | Envia ações do jogador para o servidor |

## Considerações de Segurança

- Todos os endpoints requerem autenticação via token JWT.
- Implementar retry com backoff exponencial para requests falhos.
- Utilizar Dio para gerenciamento de requests HTTP.

## Matriz de Permissões

| Endpoint | Permissão Requerida |
| --- | --- |
| `/auth/login` | Nenhuma |
| `/auth/logout` | Autenticado |
| `/user/profile` | Autenticado |
| `/game/state` | Autenticado |
| `/game/actions` | Autenticado |

## Casos de Uso

1. Ao iniciar o jogo, o cliente deve autenticar o usuário utilizando `/auth/login`.
2. Após autenticação bem-sucedida, o token JWT deve ser armazenado de forma segura.
3. O estado do jogo deve ser sincronizado periodicamente utilizando `/game/state`.
4. Ações do jogador devem ser enviadas ao servidor via `/game/actions`.

## Referências

- [Documentação da API do Passdriver](../passdriver_flutter_api_security/api_security.md)
- [Critérios de Aceitação para Passdriver Flutter](../passdriver_flutter_criterios/criterios_aceitacao.md)
