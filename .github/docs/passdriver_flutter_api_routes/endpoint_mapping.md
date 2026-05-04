# Mapeamento de Endpoints de Autenticação

Este documento detalha os endpoints de autenticação utilizados no projeto, incluindo login, logout e refresh token. São especificados os payloads de credenciais e as estruturas de JWT/Tokens retornadas.

## Endpoint: Login

* **URL:** `/auth/login`
* **Método:** `POST`
* **Payload:**
  * `username`: Nome de usuário
  * `password`: Senha do usuário
* **Resposta:**
  * `token`: JWT de autenticação
  * `refreshToken`: Token de refresh

## Endpoint: Logout

* **URL:** `/auth/logout`
* **Método:** `POST`
* **Payload:**
  * `refreshToken`: Token de refresh
* **Resposta:**
  * `success`: Indicador de sucesso na operação

## Endpoint: Refresh Token

* **URL:** `/auth/refresh-token`
* **Método:** `POST`
* **Payload:**
  * `refreshToken`: Token de refresh
* **Resposta:**
  * `token`: Novo JWT de autenticação
  * `refreshToken`: Novo token de refresh (opcional)

## Estrutura do JWT

O JWT retornado nos endpoints de login e refresh token segue o padrão de estrutura abaixo:

* **Header:**
  * `alg`: Algoritmo de assinatura (ex: HS256)
  * `typ`: Tipo do token (JWT)
* **Payload:**
  * `sub`: ID do usuário
  * `exp`: Tempo de expiração
  * `iat`: Tempo de emissão
  * `username`: Nome de usuário
* **Signature:** Assinatura do token

## Considerações de Segurança

* Todos os endpoints de autenticação devem ser acessados via HTTPS.
* O token de refresh deve ser armazenado de forma segura no cliente.
* O JWT deve ser validado no servidor antes de conceder acesso a recursos protegidos.
