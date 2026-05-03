# Critérios de Aceitação para Endpoints

## Endpoints Obrigatórios

- Endpoint para criar um novo bloco: `POST /blocos`
- Endpoint para listar todos os blocos: `GET /blocos`
- Endpoint para obter um bloco por ID: `GET /blocos/{id}`
- Endpoint para atualizar um bloco: `PUT /blocos/{id}`
- Endpoint para deletar um bloco: `DELETE /blocos/{id}`

## Renderização do Swagger

A renderização do UI do Swagger deve ser validada para garantir que os endpoints estejam corretamente documentados e funcionais.

### Renderização do Swagger validada

- [x] A UI do Swagger é renderizada corretamente
- [x] Todos os endpoints obrigatórios estão documentados
