# Solução de Problemas Comuns no Flutter

Este documento visa ajudar a resolver problemas comuns relacionados ao ambiente Flutter no projeto Rebeca.

## Erros de Instalação

1. **Flutter não encontrado**: Certifique-se de que o Flutter está instalado e configurado corretamente no seu PATH.
2. **Dependências não resolvidas**: Execute `flutter pub get` para resolver as dependências do projeto.

## Erros de Configuração

1. **Versão do Flutter incompatível**: Verifique se a versão do Flutter instalada é compatível com a especificada no `pubspec.yaml`.
2. **Configuração de assets**: Certifique-se de que os assets estão configurados corretamente no `pubspec.yaml`.

## Erros de Build

1. **Erro ao compilar**: Execute `flutter clean` e então `flutter pub get` para limpar e recriar as dependências.
2. **Erro de versão do SDK**: Verifique se a versão do SDK do Dart está dentro do intervalo especificado no `pubspec.yaml`.

## Passos Gerais para Solução de Problemas

1. **Verifique os logs**: Analise os logs de erro para identificar a causa raiz do problema.
2. **Pesquise na documentação oficial**: Consulte a documentação oficial do Flutter para soluções de problemas conhecidos.
3. **Pesquise em issues do GitHub**: Verifique se o problema já foi reportado e resolvido em issues do GitHub relacionados ao Flutter ou ao projeto Rebeca.

## Comandos Úteis

- `flutter doctor`: Verifica a configuração do ambiente Flutter.
- `flutter clean`: Limpa os artefatos de build.
- `flutter pub get`: Resolve as dependências do projeto.

