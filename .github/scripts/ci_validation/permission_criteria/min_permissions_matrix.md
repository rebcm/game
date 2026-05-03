# Matriz de Permissões Mínimas

| Ação do Pipeline | Permissão Necessária | Justificativa |
| --- | --- | --- |
| Build | Leitura/escrita no diretório de build | Compilar código e gerar artefatos |
| Deploy para Cloudflare Pages | Token de deploy da Cloudflare | Autenticar e autorizar deploy |
| Execução de testes | Leitura nos diretórios de teste | Executar testes unitários e de integração |
| Análise de código | Leitura nos diretórios de código | Analisar qualidade e segurança do código |

