#!/bin/bash

# Configura o ambiente para build de iOS
echo "Configurando o ambiente para build de iOS..."

# Verifica se o Flutter está instalado e configurado corretamente
flutter doctor

# Limpa o projeto Flutter
flutter clean

# Obtém as dependências do projeto
flutter pub get

# Constrói o aplicativo iOS
flutter build ios --release

echo "Build de iOS concluído com sucesso."
