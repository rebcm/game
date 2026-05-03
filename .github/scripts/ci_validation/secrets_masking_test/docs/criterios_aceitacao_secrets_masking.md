# Critérios de Aceitação para Teste de Máscara de Secrets

1. O teste deve ser executado durante o pipeline de CI/CD.
2. O teste deve verificar se há presença de segredos nos logs.
3. O teste deve falhar se qualquer segredo for encontrado nos logs.
