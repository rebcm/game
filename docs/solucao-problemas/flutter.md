# Solução de Problemas Comuns no Flutter

## Erros de Instalação

1. **Flutter não encontrado**: Certifique-se de que o Flutter está instalado e configurado corretamente no seu PATH.
2. **Permissão negada**: Execute os comandos com privilégios de administrador ou ajuste as permissões dos arquivos.

## Erros de Configuração

1. **Dependências não resolvidas**: Execute `flutter pub get` para atualizar as dependências.
2. **Versão do Flutter incompatível**: Verifique se a versão do Flutter está dentro do intervalo especificado no `pubspec.yaml`.

## Erros de Build

1. **Erro ao compilar**: Limpe o projeto com `flutter clean` e tente compilar novamente.
2. **Assets não encontrados**: Verifique se os assets estão corretamente configurados no `pubspec.yaml`.

## Outros Problemas

1. **Aplicativo não inicia**: Verifique os logs de erro para identificar a causa.
2. **Comportamento inesperado**: Execute o aplicativo em modo debug para identificar a causa.

## Comandos Úteis

- `flutter doctor`: Verifica a configuração do Flutter.
- `flutter clean`: Limpa o projeto.
- `flutter pub get`: Atualiza as dependências.
