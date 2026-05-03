# Critérios de Aceitação para Validação de Secrets

1. As chaves de assinatura (keystores/certs) devem ser injetadas via Secrets do repositório.
2. Não deve haver hardcoding das chaves de assinatura no pipeline.
3. O script de validação deve verificar a existência e validade das chaves.
