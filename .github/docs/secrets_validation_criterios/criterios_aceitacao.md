# Critérios de Aceitação para Validação de Secrets

1. O pipeline deve falhar quando o secret de assinatura estiver ausente.
2. O pipeline deve falhar quando o secret de assinatura estiver malformado.
3. A mensagem de erro deve ser clara e indicar a causa do problema.
