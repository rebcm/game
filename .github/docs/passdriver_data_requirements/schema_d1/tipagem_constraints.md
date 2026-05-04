# Tipagem e Constraints do Schema D1

## Tabela de Mundos (Worlds)

### Campos

| Nome do Campo | Tipo de Dado | Constraint | Descrição |
| --- | --- | --- | --- |
| id | INTEGER | PRIMARY KEY, NOT NULL, UNIQUE | Identificador único do mundo |
| nome | TEXT | NOT NULL | Nome do mundo |
| descricao | TEXT |  | Descrição do mundo |
| data_criacao | DATETIME | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Data de criação do mundo |
| data_modificacao | DATETIME | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Data de última modificação do mundo |

### Constraints

- A chave primária (`id`) é única e não nula.
- O nome do mundo (`nome`) é obrigatório.
- A data de criação (`data_criacao`) e data de modificação (`data_modificacao`) são obrigatórias e default para o timestamp atual.

### Índices

- Índice único no campo `nome` para garantir nomes de mundos únicos.

## Implementação

A implementação da tabela de mundos deve seguir as especificações acima, garantindo a integridade dos dados e a eficiência nas consultas.
{"pt-BR": "Tradução para pt-BR"}
