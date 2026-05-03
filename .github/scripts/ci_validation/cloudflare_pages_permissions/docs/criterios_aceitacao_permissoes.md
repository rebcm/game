# Critérios de Aceitação para Permissões do Cloudflare Pages

1. A matriz de permissões mínimas deve estar definida no arquivo `docs/cloudflare_pages_pipeline/minimum_permissions_matrix.md`.
2. As permissões devem seguir o princípio do menor privilégio.
3. A validação das permissões deve ser realizada pelo script `.github/scripts/ci_validation/cloudflare_pages_permissions/validate_permissions.sh`.

