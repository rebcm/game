# Estratégia de Testes de API

## Bibliotecas de Testes

Para os testes de API, será utilizada a biblioteca `mocktail` já presente nas dependências de desenvolvimento do projeto.

## Tipo de Testes

Serão implementados testes de unidade com mocks da camada de rede. Isso permitirá isolar a lógica de negócios da API e testá-la de forma independente, sem depender de chamadas reais à rede.

## Justificativa

A escolha por testes de unidade com mocks se justifica pela necessidade de garantir a estabilidade e a confiabilidade da aplicação, sem depender de fatores externos como a disponibilidade da rede ou a resposta da API.

## Implementação

Os testes serão implementados na pasta `test/api_test`. Serão criados testes para cada endpoint da API, utilizando mocks para simular as respostas da rede.
