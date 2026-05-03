# Critérios de Aceitação para Versão do Flutter SDK

## Introdução

Este documento define os critérios de aceitação para a versão do Flutter SDK utilizada no projeto.

## Critérios

1. A versão mínima do Flutter SDK deve ser compatível com as versões mínimas suportadas de Android e iOS.
2. A versão do Flutter SDK deve ser especificada no arquivo `pubspec.yaml`.
3. A versão do Flutter SDK deve ser verificada automaticamente durante a execução dos testes de CI.

## Versões Mínimas Suportadas

- Android: API Level 21 (Android 5.0)
- iOS: iOS 11

## Verificação

A verificação da versão do Flutter SDK será realizada através de um script de CI que irá comparar a versão especificada no `pubspec.yaml` com as versões mínimas suportadas.

