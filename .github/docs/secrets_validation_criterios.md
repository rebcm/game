# Critérios de Aceitação para Validação de Secrets

1. As chaves de assinatura (keystores/certs) devem ser injetadas via Secrets do repositório.
2. Não deve haver hardcoded de secrets no pipeline.
3. O script de validação deve verificar a presença e integridade dos secrets.
