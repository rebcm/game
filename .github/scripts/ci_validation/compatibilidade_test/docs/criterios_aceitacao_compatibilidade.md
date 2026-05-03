# Critérios de Aceitação para Compatibilidade

## Introdução

Este documento define os critérios de aceitação para a compatibilidade do projeto game, focando em métricas claras para build APK/Bundle, tempo de build estável e sincronização Gradle sem warnings de JDK.

## Critérios

1. **Build APK/Bundle sem erros de 'major version'**
   - O processo de build deve ser concluído sem erros relacionados à versão major do Java.

2. **Tempo de build estável**
   - O tempo de build deve ser estável e dentro de um limite aceitável definido pelo time de desenvolvimento.

3. **Sincronização Gradle concluída sem warnings de JDK**
   - A sincronização do Gradle deve ser concluída sem warnings relacionados à configuração do JDK.

## Métricas

- **Build APK/Bundle**: O processo de build deve ser monitorado para garantir que não ocorram erros de 'major version'.
- **Tempo de build**: O tempo de build será medido e comparado com o baseline estabelecido.
- **Sincronização Gradle**: A sincronização do Gradle será verificada para garantir que não haja warnings de JDK.

## Ferramentas

- `flutter build apk`
- `flutter build appbundle`
- `gradle sync`

## Baseline

O baseline para essas métricas será estabelecido após a primeira execução dos testes e será utilizado para comparações futuras.

