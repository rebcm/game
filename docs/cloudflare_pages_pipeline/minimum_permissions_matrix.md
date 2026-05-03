# Matriz de Permissões Mínimas para o Pipeline Cloudflare Pages

| Ação do Pipeline | Permissão Mínima Necessária | Justificativa |
|------------------|---------------------------|---------------|
| Deploy           | `Cloudflare Pages: Editar` | Necessária para realizar o deploy da aplicação. |
| Build            | `Cloudflare Pages: Editar` | Necessária para executar o build da aplicação. |
| Acesso às Variáveis de Ambiente | `Cloudflare Pages: Variáveis de Ambiente - Ler/Escrever` | Necessária para acessar e modificar variáveis de ambiente. |
