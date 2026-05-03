# Baseline de Versões do Flutter e Dart SDK

## Introdução

Este documento define as versões mínimas do Flutter SDK e AGP que serão utilizadas para testes com o JDK 17.

## Versões Mínimas Suportadas

- Flutter SDK: 3.0.0
- Dart SDK: >= 2.17.0 < 3.0.0
- AGP (Android Gradle Plugin): definida implicitamente pela versão do Flutter

## Justificativa

A escolha dessas versões mínimas visa garantir a compatibilidade com o JDK 17 e manter a estabilidade do projeto.

## Testes

Os testes são executados automaticamente pelo workflow `.github/workflows/ci_infra_tests/flutter_dart_sdk_baseline_test.yml`.
