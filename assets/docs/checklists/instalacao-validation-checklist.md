# Checklist de Validação de Instalação

## Requisitos Obrigatórios

1. **Versão Flutter**: Verificar se a versão do Flutter instalada é compatível com o projeto (conforme especificado no `pubspec.yaml`).
2. **Dart SDK**: Confirmar que a versão do Dart SDK está dentro do intervalo especificado no `pubspec.yaml`.
3. **Configuração de Emulador**: Verificar se um emulador está configurado corretamente e pronto para uso.
4. **Variáveis de Ambiente**: Certificar-se de que as variáveis de ambiente necessárias estão configuradas corretamente.

## Passos para Validação

1. Executar `flutter doctor` e verificar se não há problemas críticos.
2. Confirmar que o projeto compila sem erros executando `flutter pub get` seguido de `flutter build`.
3. Testar a execução do projeto em um emulador/dispositivo configurado.

## Critérios de Aceitação

- Todos os requisitos obrigatórios estão atendidos.
- O projeto compila e executa sem erros.
