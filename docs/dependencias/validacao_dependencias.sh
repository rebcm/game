#!/bin/bash

# Script para validar dependências do projeto

# Verificar se a Hive está atualizada
echo "Verificando versão da Hive..."
dart pub outdated hive

# Executar testes com versões diferentes do Flutter/Dart
echo "Executando testes de compatibilidade..."
flutter test --dart-define=FLUTTER_CHANNEL=beta

echo "Validação concluída."
