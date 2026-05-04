# Mapeamento de Endpoints de Gestão de Viagens

## Introdução

Este documento visa listar os endpoints relacionados à criação, listagem e atualização de viagens, definindo os campos obrigatórios do payload de entrada.

## Endpoints

### 1. Criação de Viagens

- **Endpoint:** `/viagens`
- **Método:** `POST`
- **Campos Obrigatórios:**
  - `destino`
  - `data_inicio`
  - `data_fim`

### 2. Listagem de Viagens

- **Endpoint:** `/viagens`
- **Método:** `GET`
- **Parâmetros de Consulta:**
  - `limit` (opcional)
  - `offset` (opcional)

### 3. Atualização de Viagens

- **Endpoint:** `/viagens/{id}`
- **Método:** `PUT`
- **Campos Obrigatórios:**
  - `destino`
  - `data_inicio`
  - `data_fim`

## Conclusão

Este documento fornece uma visão geral dos endpoints necessários para a gestão de viagens, facilitando a integração com a API.
