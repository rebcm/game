# Guia de Diferenciação entre Secrets e Vars

Este guia tem como objetivo esclarecer a diferenciação entre Secrets e Vars no contexto do projeto Rebeca.

## Introdução

No desenvolvimento do projeto Rebeca, utilizamos o Wrangler para gerenciar variáveis de configuração. É fundamental entender a diferença entre Secrets e Vars para garantir a segurança e a flexibilidade do projeto.

## Secrets

Secrets são variáveis criptografadas utilizadas para armazenar informações sensíveis, como chaves de API, tokens de autenticação e outras credenciais. Eles são armazenados de forma segura e não são expostos em plain text nos arquivos de configuração.

### Quando usar Secrets?

- Armazenar chaves de API ou tokens de autenticação.
- Proteger credenciais de acesso a serviços externos.
- Manter informações sensíveis que não devem ser expostas.

## Vars

Vars são variáveis de configuração que armazenam valores não sensíveis, como IDs de recursos, URLs públicas e outras configurações que não comprometem a segurança do projeto.

### Quando usar Vars?

- Configurar IDs de recursos ou URLs públicas.
- Armazenar valores que não são sensíveis e podem ser expostos.
- Definir configurações que precisam ser facilmente alteradas.

## Matriz de Decisão

| Tipo de Informação | Exemplo | Recomendação |
| --- | --- | --- |
| Chaves de API | Chave de acesso à API do Cloudflare | Secret |
| Tokens de Autenticação | Token de autenticação para deploy | Secret |
| IDs de Recursos | ID do projeto no Cloudflare | Var |
| URLs Públicas | URL da documentação | Var |
| Credenciais de Acesso | Senha de acesso ao banco de dados | Secret |

## Conclusão

A diferenciação correta entre Secrets e Vars é crucial para manter a segurança e a organização do projeto Rebeca. Ao seguir as diretrizes deste guia, você pode garantir que as informações sensíveis sejam protegidas e que as configurações sejam gerenciadas de forma eficaz.
