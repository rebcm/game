# Dependências do Projeto

## Introdução

Este documento lista as dependências do projeto `game`, conforme especificado no arquivo `pubspec.yaml`. As dependências são categorizadas por funcionalidade e incluem as versões fixas (pinned versions) utilizadas.

## Dependências de Produção

As seguintes dependências são utilizadas em produção:

### Flutter e SDK

- `flutter`: SDK Flutter (`sdk: flutter`)

### Bibliotecas de Terceiros

- `flutter_dotenv`: ^5.0.2 - Carregamento de variáveis de ambiente
- `quiver`: ^3.2.1 - Utilitários diversos para Dart
- `freezed_annotation`: ^2.4.1 - Anotações para geração de código com freezed
- `audioplayers`: ^5.2.0 - Reprodução de áudio
- `http`: ^0.13.6 - Cliente HTTP
- `ffmpeg_kit_flutter`: ^4.5.1 - Processamento de vídeo e áudio com FFmpeg

## Dependências de Desenvolvimento

As seguintes dependências são utilizadas apenas durante o desenvolvimento:

- `freezed`: ^2.4.7 - Geração de código para classes imutáveis
- `build_runner`: ^2.4.6 - Execução de builders para geração de código
- `flutter_test`: SDK Flutter (`sdk: flutter`) - Testes de widget Flutter
- `flutter_lints`: ^3.0.0 - Lints para projetos Flutter
- `integration_test`: SDK Flutter (`sdk: flutter`) - Testes de integração

## Conclusão

Este documento lista as dependências do projeto `game`, categorizadas por funcionalidade. É importante manter as versões das dependências atualizadas e compatíveis com o projeto.
