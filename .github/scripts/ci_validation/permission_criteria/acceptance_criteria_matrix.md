# Matriz de Critérios de Aceitação para Permissões

## Visão Geral
Este documento define os critérios de aceitação para as permissões necessárias no aplicativo, focando nas plataformas iOS e Android.

## Critérios de Aceitação

### iOS
- **NSMicrophoneUsageDescription**: Deve estar presente no arquivo `Info.plist`.
  - **Descrição**: A justificativa para o uso do microfone deve ser clara e concisa, explicando por que o aplicativo precisa acessar o microfone.
  - **Exemplo**: "Este aplicativo precisa acessar o microfone para funcionalidades específicas."

### Android
- **RECORD_AUDIO**: Deve ser declarada no `AndroidManifest.xml`.
  - **Descrição**: A permissão para gravar áudio deve ser solicitada quando necessária, com uma justificativa clara para o usuário.
  - **Exemplo**: "Permita o acesso ao microfone para usar funcionalidades de áudio."

## Validação
- **iOS**: Verificar se `NSMicrophoneUsageDescription` está presente e corretamente configurado no `Info.plist`.
- **Android**: Verificar se `RECORD_AUDIO` está declarada no `AndroidManifest.xml` e se a solicitação de permissão é feita corretamente.

## Testes
- Testar a solicitação de permissão em ambos os dispositivos iOS e Android.
- Validar se a funcionalidade que requer o microfone funciona corretamente após a permissão ser concedida.
