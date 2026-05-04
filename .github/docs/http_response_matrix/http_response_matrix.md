# Matriz de Respostas HTTP

| Endpoint | Método | Status 200 | Status 400 | Status 401 | Status 500 |
| --- | --- | --- | --- | --- | --- |
| /api/exemplo | GET | `{ "mensagem": "Sucesso" }` | `{ "erro": "Requisição inválida" }` | `{ "erro": "Não autorizado" }` | `{ "erro": "Erro interno do servidor" }` |
