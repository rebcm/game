# Matriz de Versões do Setup

| Ferramenta | Versão |
|------------|--------|
| Flutter    | $(flutter --version | grep "Flutter" | awk '{print $2}') |
| Dart       | $(dart --version | grep "Dart" | awk '{print $4}' | sed 's/.$//') |
| Java       | $(java -version 2>&1 | grep "version" | awk '{print $3}' | sed 's/"//g') |

## Propósito

Documentar as versões exatas do Flutter, Dart e Java utilizadas no projeto para garantir consistência entre diferentes ambientes de desenvolvimento e builds.

## Manutenção

Este documento deve ser atualizado sempre que houver uma mudança nas versões das ferramentas utilizadas no projeto.
{"pt-BR": "Tradução para pt-BR"}
