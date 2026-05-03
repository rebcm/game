# Matriz de Critérios de Aceitação para Permissões

## Visão Geral

Este documento define os critérios de aceitação para as permissões necessárias no aplicativo, focando especificamente nas permissões de microfone para iOS e Android.

## Critérios de Aceitação

### Permissão de Microfone

#### iOS (NSMicrophoneUsageDescription)
- **Critério 1:** A chave `NSMicrophoneUsageDescription` deve estar presente no arquivo `Info.plist`.
- **Critério 2:** O valor associado à chave `NSMicrophoneUsageDescription` deve ser uma string que justifique claramente o uso do microfone pelo aplicativo.
- **Critério 3:** A justificativa fornecida deve ser clara e concisa, informando o usuário sobre como o aplicativo utiliza o microfone.

#### Android (RECORD_AUDIO)
- **Critério 1:** A permissão `RECORD_AUDIO` deve estar declarada no arquivo `AndroidManifest.xml`.
- **Critério 2:** O aplicativo deve solicitar a permissão `RECORD_AUDIO` em tempo de execução quando necessário.
- **Critério 3:** O texto de justificativa para a permissão deve ser claro e informativo, explicando ao usuário por que o aplicativo precisa acessar o microfone.

## Validação

- **Critério 4:** O aplicativo deve passar nos testes de validação de permissão de microfone, verificando se as condições acima são atendidas.
- **Critério 5:** A CI/CD pipeline deve incluir etapas para verificar a presença e a correta configuração das permissões de microfone.

## Referências

- [Documentação do iOS sobre NSCameraUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsmicrophoneusagedescription)
- [Documentação do Android sobre permissão RECORD_AUDIO](https://developer.android.com/reference/android/Manifest.permission#RECORD_AUDIO)

