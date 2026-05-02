# Guia de Instalação do Flutter para o Projeto Rebeca

Este guia fornece instruções passo a passo para instalar o Flutter e configurar o ambiente de desenvolvimento para o projeto Rebeca.

## Pré-requisitos

- Sistema Operacional: Windows, macOS ou Linux
- Espaço em disco: 3 GB (incluindo o SDK do Flutter e o Android Studio)
- Git instalado (para clonar o repositório)

## Passo 1: Instalar o Flutter SDK

1. Baixe o SDK do Flutter da [página oficial](https://docs.flutter.dev/get-started/install).
2. Extraia o arquivo baixado para um diretório de sua escolha (por exemplo, `C:\src\flutter` no Windows ou `~/development/flutter` no macOS/Linux).
3. Adicione o diretório do Flutter ao seu PATH:
   - No Windows: Adicione `C:\src\flutter\bin` às variáveis de ambiente.
   - No macOS/Linux: Adicione `export PATH="$PATH:~/development/flutter/bin"` ao seu arquivo de configuração do shell (`.bashrc`, `.zshrc`, etc.).

## Passo 2: Instalar o Android Studio (para desenvolvimento Android)

1. Baixe e instale o [Android Studio](https://developer.android.com/studio).
2. Abra o Android Studio e siga as instruções para instalar o SDK do Android e configurar o ambiente.

## Passo 3: Configurar o Ambiente de Desenvolvimento

1. Execute `flutter doctor` no terminal para verificar se o Flutter está instalado corretamente e identificar quaisquer problemas.
2. Instale as dependências necessárias conforme indicado pelo `flutter doctor`.
3. Configure um emulador Android ou conecte um dispositivo físico para testar o aplicativo.

## Passo 4: Clonar o Repositório do Projeto Rebeca

1. Abra um terminal e navegue até o diretório onde deseja clonar o repositório.
2. Execute `git clone https://github.com/rebcm/game.git` para clonar o repositório.

## Passo 5: Executar o Projeto

1. Navegue até o diretório do projeto clonado: `cd game`.
2. Execute `flutter pub get` para obter as dependências do projeto.
3. Execute `flutter run` para iniciar o aplicativo no emulador ou dispositivo conectado.

## Solução de Problemas Comuns

- Se ocorrerem erros durante a instalação, verifique se todos os pré-requisitos foram atendidos e se o Flutter SDK está corretamente configurado.
- Para problemas específicos do Android Studio, consulte a [documentação oficial](https://developer.android.com/studio/intro).

## Conclusão

Seguindo estes passos, você deve ser capaz de instalar o Flutter e configurar o ambiente de desenvolvimento para o projeto Rebeca. Se encontrar problemas adicionais, consulte a documentação oficial do Flutter ou entre em contato com a equipe do projeto.
