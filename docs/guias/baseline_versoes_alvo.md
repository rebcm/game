# Baseline de Versões Alvo

## Introdução

Este documento define as versões mínimas de Flutter SDK e AGP que serão testadas contra o JDK 17 para evitar testes aleatórios.

## Versões Alvo

- Flutter SDK: 3.0.0
- AGP: 7.0.0

## Justificativa

A escolha dessas versões se baseia na necessidade de garantir a compatibilidade com o JDK 17 e evitar problemas de compatibilidade com versões mais antigas.

## Testes

Os testes serão realizados automaticamente pelo workflow `flutter_dart_sdk_baseline_test.yml` em cada push para a branch main.
