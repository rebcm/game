# Mapeamento de Códigos de Erro HTTP Esperados

Este documento descreve os códigos de erro HTTP que o pipeline deve capturar e como deve ser a mensagem de erro final para o desenvolvedor.

## Códigos de Erro HTTP

| Código | Descrição | Mensagem de Erro |
| --- | --- | --- |
| 401 | Não autorizado | "Não autorizado. Verifique suas credenciais." |
| 403 | Proibido | "Acesso proibido. Verifique suas permissões." |
| 507 | Armazenamento insuficiente | "Armazenamento insuficiente. Contate o suporte." |

## Implementação

Para implementar a captura desses códigos de erro, você deve modificar o pipeline para verificar as respostas HTTP e exibir a mensagem de erro correspondente.

