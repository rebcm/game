# Procedimento de Rollback

## Introdução
Este documento detalha o procedimento para reverter o jogo Rebeca para uma versão anterior em caso de falha crítica após o deploy.

## Etapas do Rollback
1. **Identificar a Falha**: Registre os sintomas da falha e verifique os logs para entender a causa.
2. **Identificar a Versão Estável Anterior**: Consulte o histórico de commits para encontrar a última versão estável.
3. **Executar o Rollback**: Utilize o GitHub Actions para re-deploy da versão estável anterior.
   - Acesse o workflow de deploy e selecione a opção de re-executar o deploy para a versão desejada.

## Boas Práticas
- Documente a falha e as ações tomadas para corrigi-la.
- Realize testes rigorosos após o rollback para garantir a estabilidade do jogo.
