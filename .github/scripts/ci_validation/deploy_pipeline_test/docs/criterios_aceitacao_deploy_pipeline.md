# Critérios de Aceitação para Teste de Pipeline de Deploy

1. **Validação de Build do Flutter Web**: O build do Flutter Web deve ser bem-sucedido sem erros.
2. **Verificação de Conectividade com Cloudflare**: A conexão com Cloudflare deve ser estabelecida com sucesso.
3. **Teste de Rollback em Caso de Falha no Deploy**: Em caso de falha no deploy, o sistema deve realizar o rollback para a versão anterior com sucesso.

## Passos para Execução do Teste

1. Executar o comando de build do Flutter Web.
2. Verificar os logs de deploy para garantir que a conexão com Cloudflare foi bem-sucedida.
3. Simular uma falha no deploy e verificar se o rollback foi executado corretamente.

## Critérios de Sucesso

- O build do Flutter Web é concluído sem erros.
- A conectividade com Cloudflare é verificada com sucesso.
- O rollback é executado corretamente em caso de falha no deploy.
