# Configuração do Ambiente de Desenvolvimento

Este guia cobre a configuração do ambiente de desenvolvimento para o projeto Rebeca Voxel Game em diferentes sistemas operacionais (Windows, macOS, Linux) e versões do Flutter SDK.

## Pré-requisitos

- Flutter SDK
- Dart SDK
- Um editor de código ou IDE (como Android Studio ou Visual Studio Code)

## Passos para Configuração

1. **Instalar o Flutter SDK**:
   - Vá para o [site oficial do Flutter](https://docs.flutter.dev/get-started/install) e siga as instruções de instalação para o seu sistema operacional.

2. **Configurar o Ambiente**:
   - Após a instalação, certifique-se de que o Flutter SDK está corretamente configurado executando `flutter doctor` no terminal.

3. **Clonar o Repositório**:
   - Clone o repositório do jogo usando `git clone https://github.com/rebcm/game.git` (embora o uso de git seja evitado aqui, essa etapa é mencionada para contexto).

4. **Instalar Dependências**:
   - Execute `flutter pub get` na raiz do projeto para instalar as dependências listadas no `pubspec.yaml`.

## Configuração Específica por SO

### Windows
- Certifique-se de ter o Windows 10 ou superior (64-bit).
- Instale o [Visual Studio](https://visualstudio.microsoft.com/downloads/) com as ferramentas de desenvolvimento para desktop com C++.

### macOS
- Certifique-se de ter o macOS 10.14 ou superior.
- Instale o Xcode da App Store.

### Linux
- Certifique-se de ter uma distribuição Linux compatível (por exemplo, Ubuntu 18.04 ou superior).
- Instale as dependências necessárias, como `clang`, `cmake`, `ninja-build`, `pkg-config`, `gtk3`, etc.

## Versões do Flutter SDK Suportadas

O projeto é compatível com Flutter SDK versão >=3.0.0, conforme especificado no `pubspec.yaml`. Certifique-se de que sua versão atende a esse requisito.

## Solução de Problemas Comuns

- Se encontrar problemas com a configuração do ambiente, execute `flutter doctor` para obter ajuda.
- Certifique-se de que todas as dependências estão atualizadas.

## Conclusão

Seguindo esses passos, você deve ser capaz de configurar o ambiente de desenvolvimento para o Rebeca Voxel Game em diferentes sistemas operacionais e versões do Flutter SDK.
