# Matriz de Permissões Mínimas

| Ação do Pipeline | Permissão Mínima Necessária | Justificativa |
|------------------|---------------------------|---------------|
| Deploy Cloudflare Pages | Acesso ao token da Cloudflare | Necessário para autenticação e deploy |
| Execução de Scripts CI | Permissão de execução de scripts | Necessário para rodar scripts de validação e build |
| Acesso a Recursos do Flutter | Permissão de leitura e escrita para diretórios de build | Necessário para compilar e gerar artefatos |
