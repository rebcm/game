# Processo de Deploy e Rollback

## Introdução

Este documento descreve o processo de deploy e rollback para a aplicação Flutter do projeto Rebeca.

## Deploy

O deploy é realizado automaticamente através do GitHub Actions. O workflow responsável pelo deploy está configurado no arquivo `./.github/workflows/ci-cd.yml`.

### Passos do Deploy

1. **Build**: A aplicação é compilada para as plataformas suportadas (Web, iOS, etc.).
2. **Testes**: São executados testes automatizados para garantir a integridade da aplicação.
3. **Upload**: Os artefatos gerados são enviados para o servidor de distribuição.

## Rollback

Em caso de falha crítica, é possível reverter para uma versão anterior da aplicação.

### Passos do Rollback

1. **Identificar a versão anterior**: Localize a versão anterior estável da aplicação no histórico de commits.
2. **Executar o deploy da versão anterior**: Utilize o GitHub Actions para executar novamente o workflow de deploy com a versão anterior.

### Comando para Rollback

Não há um comando direto para rollback. É necessário utilizar a interface do GitHub para executar novamente o workflow de deploy com a versão desejada.

## Considerações Finais

O processo de deploy e rollback é automatizado e gerenciado pelo GitHub Actions. Em caso de dúvidas ou problemas, consulte a documentação do GitHub Actions ou entre em contato com a equipe de desenvolvimento.
