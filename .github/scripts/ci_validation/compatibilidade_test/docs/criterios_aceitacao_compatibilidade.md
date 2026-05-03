# Critérios de Aceitação para Compatibilidade

## Introdução

Este documento define os critérios de aceitação para a compatibilidade do projeto "Construção Criativa da Rebeca". Os critérios aqui estabelecidos visam garantir que o aplicativo seja construído e executado sem erros ou warnings relacionados à compatibilidade.

## Critérios

1. **Build APK/Bundle sem erros de 'major version'**: O processo de build deve ser concluído sem erros relacionados à versão major do JDK ou da ferramenta de build.
2. **Tempo de build estável**: O tempo de build deve ser estável e não deve variar significativamente entre diferentes execuções.
3. **Sincronização Gradle concluída sem warnings de JDK**: A sincronização do Gradle deve ser concluída sem warnings relacionados à versão do JDK.

## Métricas de Sucesso

- O build do APK/Bundle é concluído sem erros de 'major version'.
- O tempo de build é estável e dentro dos limites estabelecidos.
- A sincronização do Gradle é concluída sem warnings de JDK.

## Responsabilidades

- A equipe de desenvolvimento é responsável por garantir que o código seja compatível com as versões das ferramentas e dependências utilizadas.
- A equipe de CI/CD é responsável por monitorar os resultados dos builds e sincronizações.

## Referências

- [Documentação do Gradle JDK Mapping](../gradle_jdk_mapping/gradle_jdk_compatibility.md)
