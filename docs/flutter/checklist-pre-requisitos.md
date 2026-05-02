# Checklist de Pré-requisitos para Documentação do Flutter

## Versão do Flutter/Dart
- Versão do Flutter: 3.16.5 ou superior
- Versão do Dart: 3.2.3 ou superior

## SDKs Android/iOS
- Android SDK: API nível 33 ou superior
- iOS SDK: 17.0 ou superior

## Variáveis de Ambiente
- `FLUTTER_ROOT`: caminho para o diretório raiz do Flutter
- `ANDROID_HOME`: caminho para o diretório do Android SDK

## Chaves de API Necessárias
- Chave da API do OpenStreetMap (para uso com `flutter_map`)

## Passos de Validação do Build
1. Execute `flutter doctor` para verificar o ambiente de desenvolvimento.
2. Execute `flutter pub get` para obter as dependências do projeto.
3. Compile e execute o aplicativo em um emulador ou dispositivo físico.

## Configuração Adicional
- Certifique-se de ter configurado corretamente as variáveis de ambiente.
- Verifique se as chaves de API necessárias estão configuradas corretamente no arquivo `lib/config/api_keys.dart`.

