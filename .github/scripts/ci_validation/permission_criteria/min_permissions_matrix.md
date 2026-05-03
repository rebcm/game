# Matriz Mínima de Permissões

## Visão Geral

Este documento define a matriz mínima de permissões necessárias para o funcionamento do aplicativo.

## Permissões Mínimas

| Plataforma | Permissão | Descrição |
| --- | --- | --- |
| iOS | NSMicrophoneUsageDescription | Acesso ao microfone |
| Android | RECORD_AUDIO | Gravação de áudio |

## Requisitos

1. O aplicativo deve ter as permissões mínimas listadas acima.
2. As permissões devem ser configuradas corretamente nos arquivos de configuração (`Info.plist` e `AndroidManifest.xml`).

