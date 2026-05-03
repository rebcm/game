# Critérios de Aceitação para Teste de Máscara de Secrets

1. O log de teste não deve conter senhas ou tokens em texto claro.
2. O script de teste deve falhar se qualquer segredo for encontrado no log.
3. O teste deve ser executado como parte do pipeline de CI/CD.
