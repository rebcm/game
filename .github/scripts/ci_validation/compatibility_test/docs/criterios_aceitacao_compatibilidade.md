# Critérios de Aceitação para Compatibilidade

## Introdução

Este documento define os critérios de aceitação para a compatibilidade do projeto "Construção Criativa da Rebeca". Os critérios aqui estabelecidos visam garantir que o aplicativo seja construído e executado sem erros significativos relacionados à versão do Java, tempo de build e sincronização do Gradle.

## Critérios

1. **Build APK/Bundle sem erros de 'major version'**:
   - O processo de build do APK ou Bundle deve ser concluído sem erros relacionados à versão major do Java.

2. **Tempo de build estável**:
   - O tempo necessário para realizar o build do projeto não deve apresentar variações significativas entre diferentes execuções.

3. **Sincronização Gradle concluída sem warnings de JDK**:
   - A sincronização do Gradle deve ser concluída sem warnings relacionados à configuração do JDK.

## Validação

Os critérios acima devem ser validados através de testes automatizados que verifiquem o processo de build e sincronização do Gradle.

## Script de Validação

Um script de validação deve ser criado para verificar automaticamente os critérios estabelecidos. O script deve ser capaz de:
- Executar o build do APK/Bundle e verificar se há erros de 'major version'.
- Medir o tempo de build e compará-lo entre diferentes execuções para garantir estabilidade.
- Verificar se a sincronização do Gradle apresenta warnings relacionados ao JDK.

