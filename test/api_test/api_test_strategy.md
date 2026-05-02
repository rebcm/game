# Estratégia de Testes de API

## Bibliotecas de Testes

Para os testes de API, será utilizada a biblioteca `mocktail` já presente nas dependências de desenvolvimento do projeto.

## Tipo de Testes

Serão implementados testes de unidade com mocks da camada de rede. Isso permitirá isolar a lógica de negócios da API e testá-la de forma independente, sem depender de chamadas reais à API.

## Vantagens

* Maior controle sobre os dados de teste
* Maior velocidade de execução dos testes
* Menor dependência de infraestrutura externa

## Desvantagens

* Maior complexidade na configuração dos mocks
* Possibilidade de divergência entre os testes e a realidade da API

## Implementação

Os testes serão implementados utilizando a biblioteca `test` e `mocktail`. Os arquivos de teste serão criados na pasta `test/api_test`.
