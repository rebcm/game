# Guia de Profiling de Memória

Este guia fornece instruções passo a passo sobre como realizar o profiling de memória no jogo utilizando as ferramentas do Flutter.

## Pré-requisitos

- Flutter instalado na versão especificada no `pubspec.yaml`
- Conhecimento básico das ferramentas de desenvolvimento do Flutter

## Passos para Realizar o Profiling de Memória

1. **Inicie o Aplicativo em Modo de Depuração**: Execute o comando `flutter run --profile` no terminal para iniciar o aplicativo em modo de perfilagem.

2. **Abra o DevTools**: Com o aplicativo em execução, abra o DevTools executando `flutter pub global run devtools` no terminal. Isso abrirá uma interface web onde você poderá monitorar o uso de memória.

3. **Conecte-se ao Aplicativo**: No DevTools, conecte-se ao aplicativo que está sendo executado em modo de perfilagem.

4. **Navegue até a Aba de Memória**: Na interface do DevTools, navegue até a aba de memória para visualizar o uso de memória do aplicativo.

5. **Realize as Ações Desejadas no Aplicativo**: Interaja com o aplicativo de maneira a reproduzir as ações que você deseja testar quanto ao uso de memória.

6. **Capture um Snapshot de Memória**: Utilize a funcionalidade de snapshot do DevTools para capturar o estado atual da memória. Isso ajudará a identificar objetos que permanecem na memória quando deveriam ter sido liberados.

7. **Analise os Resultados**: Examine os dados capturados para identificar possíveis vazamentos de memória ou áreas de melhoria.

## Dicas Adicionais

- Utilize o filtro de snapshots para comparar diferentes estados de memória e identificar mudanças significativas.
- Consulte a documentação oficial do Flutter para obter mais informações sobre como utilizar efetivamente as ferramentas de profiling.

## Referências

- [Documentação do Flutter DevTools](https://flutter.dev/docs/development/tools/devtools/overview)
