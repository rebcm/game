# Compatibilidade de Plugins de Terceiros com JDK 17

## Introdução

Este documento visa validar a compatibilidade dos plugins listados no `pubspec.yaml` que utilizam código nativo Android com o JDK 17, identificando possíveis deprecations no Android Gradle Plugin (AGP).

## Plugins que Utilizam Código Nativo Android

1. **permission_handler**: Este plugin utiliza código nativo Android para gerenciar permissões.

## Análise de Compatibilidade

### permission_handler

- **Versão Atual**: ^10.3.0
- **Compatibilidade com JDK 17**: Sim, de acordo com a documentação oficial do plugin.
- **Deprecations no AGP**: Não há deprecations conhecidas com a versão atual do AGP.

## Conclusão

Os plugins que utilizam código nativo Android listados no `pubspec.yaml` são compatíveis com o JDK 17. Não foram identificadas deprecations no AGP que afetem esses plugins.

## Recomendações

1. Manter os plugins atualizados para garantir a compatibilidade contínua com novas versões do JDK e AGP.
2. Monitorar as documentações dos plugins para futuras atualizações que possam afetar a compatibilidade.

{"pt-BR": "Tradução para pt-BR"}
