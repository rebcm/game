# Matriz de Critérios de Aceitação para Permissões

## Visão Geral

Este documento define os critérios de aceitação para as permissões necessárias no aplicativo.

## Permissões Necessárias

### iOS

| Permissão | Descrição | Chave Info.plist | Texto de Justificativa |
| --- | --- | --- | --- |
| Microfone | Acesso ao microfone para gravação de áudio | NSMicrophoneUsageDescription | "Este aplicativo precisa acessar o microfone para gravar áudio." |

### Android

| Permissão | Descrição | Permissão AndroidManifest.xml | Texto de Justificativa |
| --- | --- | --- | --- |
| Gravação de Áudio | Acesso para gravar áudio | RECORD_AUDIO | "Este aplicativo precisa acessar o microfone para gravar áudio." |

## Critérios de Aceitação

1. O aplicativo deve solicitar a permissão de gravação de áudio quando necessário.
2. O texto de justificativa para a permissão deve ser claro e conciso.
3. A chave Info.plist (NSMicrophoneUsageDescription) deve estar presente e configurada corretamente para iOS.
4. A permissão AndroidManifest.xml (RECORD_AUDIO) deve estar declarada corretamente para Android.
5. O aplicativo deve funcionar corretamente após a permissão ser concedida ou negada.

## Validação

A validação das permissões será realizada por meio de testes de integração e verificações estáticas no código.
