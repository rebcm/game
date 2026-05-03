# Matriz de Critérios de Aceitação para Permissões

## Visão Geral
Este documento define os critérios de aceitação para as permissões necessárias no aplicativo, focando nas plataformas iOS e Android.

## Critérios de Aceitação

### iOS
| Permissão | Descrição | Chave Info.plist | Texto de Justificativa |
|-----------|-----------|------------------|------------------------|
| Microfone | Acesso ao microfone para funcionalidades de áudio | NSMicrophoneUsageDescription | "Este aplicativo precisa acessar o microfone para gravar áudio." |

### Android
| Permissão | Descrição | Permissão AndroidManifest.xml | Texto de Justificativa |
|-----------|-----------|-------------------------------|------------------------|
| Gravação de Áudio | Acesso para gravar áudio | RECORD_AUDIO | "Este aplicativo precisa acessar o microfone para gravar áudio." |

## Validação
- [ ] Verificar se a chave `NSMicrophoneUsageDescription` está presente no `Info.plist` para iOS.
- [ ] Validar se o texto de justificativa para o microfone está correto no `Info.plist`.
- [ ] Confirmar se a permissão `RECORD_AUDIO` está declarada no `AndroidManifest.xml` para Android.
- [ ] Verificar se o texto de justificativa para a gravação de áudio está correto durante a solicitação de permissão em tempo de execução no Android.

## Automação
Os testes de validação para essas permissões devem ser implementados nos scripts de CI para garantir que as configurações estejam corretas em cada build.
