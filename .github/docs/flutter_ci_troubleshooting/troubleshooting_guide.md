# Guia de Solução de Problemas do Flutter no CI

## Introdução

Este guia visa ajudar a resolver problemas comuns que ocorrem durante a execução do Flutter no ambiente de Integração Contínua (CI).

## Problemas Comuns e Soluções

### 1. Problemas de Cache de Pods

- **Sintoma**: Erros relacionados ao cache de pods durante a execução do `pod install`.
- **Solução**: Limpe o cache de pods executando `pod cache clean --all` antes de executar `pod install`.

### 2. Versão Incompatível do SDK do Flutter

- **Sintoma**: Erros de compilação devido à versão do SDK do Flutter ser incompatível com as dependências do projeto.
- **Solução**: Verifique a versão do SDK do Flutter especificada no arquivo `.github/workflows/main.yml` e certifique-se de que ela é compatível com as dependências listadas no `pubspec.yaml`.

### 3. Falha ao Resolver Dependências

- **Sintoma**: Erros ao resolver dependências durante o `flutter pub get`.
- **Solução**: Execute `flutter pub get` localmente para verificar se as dependências estão corretas. Se o problema persistir, verifique a conectividade com o repositório de pacotes.

## Passos para Diagnosticar Problemas

1. Verifique os logs de CI para identificar a causa raiz do problema.
2. Execute o comando ou workflow localmente para reproduzir o erro.
3. Consulte a documentação oficial do Flutter e do CI para obter mais informações sobre o erro específico.

## Melhores Práticas

- Mantenha o `pubspec.yaml` e o `pubspec.lock` atualizados.
- Limpe regularmente o cache de dependências no ambiente de CI.
- Verifique a compatibilidade das versões das dependências com a versão do SDK do Flutter.

{"pt-BR": "Tradução para pt-BR"}
