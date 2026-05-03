# Matriz de Critérios de Aceitação para Permissões

## Visão Geral

Este documento define os critérios de aceitação para as permissões necessárias no aplicativo.

## Permissões Necessárias

### iOS

| Permissão | Descrição | Chave Info.plist | Texto de Justificativa |
| --- | --- | --- | --- |
| Microfone | Acesso ao microfone para gravação de áudio | NSMicrophoneUsageDescription | "O aplicativo precisa acessar o microfone para gravar áudio." |

### Android

| Permissão | Descrição | Permissão AndroidManifest.xml | Texto de Justificativa |
| --- | --- | --- | --- |
| Gravação de Áudio | Acesso para gravar áudio | RECORD_AUDIO | "O aplicativo precisa acessar o microfone para gravar áudio." |

## Critérios de Aceitação

1. O aplicativo deve solicitar a permissão de gravação de áudio quando necessário.
2. O texto de justificativa para a permissão deve ser apresentado ao usuário.
3. A chave `NSMicrophoneUsageDescription` deve estar presente no arquivo `Info.plist` para iOS.
4. A permissão `RECORD_AUDIO` deve estar declarada no arquivo `AndroidManifest.xml` para Android.
5. O texto de justificativa deve ser claro e conciso, explicando por que o aplicativo precisa da permissão.

## Validação

A validação das permissões será realizada por meio de testes de integração e verificação das configurações nos arquivos de configuração (`Info.plist` e `AndroidManifest.xml`).
