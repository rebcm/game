# Critérios de Aceitação para Versão do Flutter SDK

## Introdução

Este documento define os critérios de aceitação para a versão do Flutter SDK utilizada no projeto.

## Requisitos

1. A versão do Flutter SDK deve ser compatível com as versões mínimas suportadas de Android e iOS.
2. A versão do Flutter SDK deve ser especificada no arquivo `pubspec.yaml`.
3. A documentação deve ser atualizada para refletir a versão mínima suportada do Flutter SDK.

## Critérios de Aceitação

1. A versão do Flutter SDK é >= 3.0.0.
2. A versão mínima suportada do Android é API Level 21 (Android 5.0).
3. A versão mínima suportada do iOS é iOS 12.
4. O arquivo `docs/flutter_sdk_version.md` está atualizado com as informações de versão mínima suportada.

## Testes

1. Executar `flutter doctor` para verificar a versão do Flutter SDK.
2. Verificar a documentação em `docs/flutter_sdk_version.md` para confirmar as informações de versão mínima suportada.
