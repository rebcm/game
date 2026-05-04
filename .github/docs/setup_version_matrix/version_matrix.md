# Matriz de Versões do Setup

Este documento registra as versões exatas do Flutter, Dart e Java utilizadas no projeto para garantir a consistência entre diferentes ambientes de build.

## Versões Utilizadas

| Ferramenta | Versão |
|------------|--------|
| Flutter    | $(flutter --version | grep "Flutter" | awk '{print $2}') |
| Dart       | $(dart --version | grep "Dart" | awk '{print $4}' | sed 's/.$//') |
| Java       | $(java -version 2>&1 | grep "version" | awk '{print $3}' | sed 's/"//g') |

## Como Atualizar

1. Execute o comando `flutter --version` e registre a versão do Flutter.
2. Execute o comando `dart --version` e registre a versão do Dart.
3. Execute o comando `java -version` e registre a versão do Java.
4. Atualize a tabela acima com as versões registradas.

## Importância

Manter essas versões consistentes é crucial para evitar problemas de compatibilidade e garantir que o projeto seja construído de forma reprodutível em diferentes ambientes.
