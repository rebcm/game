# Matriz de Compatibilidade

Este documento detalha a combinação exata de Flutter SDK, Gradle, AGP e JDK 17 homologada para o projeto Rebeca.

## Versões Homologadas

| Componente | Versão |
| --- | --- |
| Flutter SDK | `flutter --version` |
| Gradle | `./gradlew --version` |
| AGP (Android Gradle Plugin) | `grep "com.android.tools.build:gradle:" build.gradle` |
| JDK | `java --version` |

## Configuração

Para garantir a compatibilidade, utilize as versões acima. Abaixo estão os passos para configurar o ambiente:

1. Instale o Flutter SDK na versão especificada.
2. Configure o Gradle para a versão especificada no arquivo `gradle/wrapper/gradle-wrapper.properties`.
3. Verifique a versão do AGP no arquivo `build.gradle`.
4. Certifique-se de que o JDK 17 está instalado e configurado como padrão.

## Verificação

Para verificar as versões, execute os comandos listados na tabela "Versões Homologadas".

