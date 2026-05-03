# Guia de Estilo de Pastas

Este documento fornece uma visão geral da estrutura de pastas do projeto Flutter, mapeando cada camada da arquitetura para pastas específicas.

## Estrutura de Pastas

A estrutura de pastas do projeto é organizada da seguinte forma:

* `data`: Camada de dados, responsável por armazenar e fornecer acesso aos dados do aplicativo.
	+ `models`: Modelos de dados utilizados pelo aplicativo.
	+ `repositories`: Repositórios de dados que encapsulam a lógica de acesso aos dados.
	+ `services`: Serviços que fornecem funcionalidades relacionadas a dados.
* `domain`: Camada de domínio, responsável por definir as regras de negócios e entidades do aplicativo.
	+ `entities`: Entidades que representam os conceitos do domínio.
	+ `usecases`: Casos de uso que encapsulam a lógica de negócios.
* `presentation`: Camada de apresentação, responsável por renderizar a interface do usuário.
	+ `pages`: Páginas que compõem a interface do usuário.
	+ `widgets`: Componentes de interface do usuário reutilizáveis.

## Convenções de Nomenclatura

* Pastas e arquivos devem ser nomeados de forma clara e concisa, refletindo seu propósito.
* Nomes de pastas e arquivos devem ser em minúsculas, com palavras separadas por underscores.

## Diretrizes para Organização

* Manter a estrutura de pastas organizada e consistente.
* Evitar a criação de pastas desnecessárias ou redundantes.
* Utilizar as pastas existentes para armazenar arquivos relacionados.

