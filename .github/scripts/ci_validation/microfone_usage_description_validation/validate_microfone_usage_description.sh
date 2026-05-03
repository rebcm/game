#!/bin/bash

description=$(grep -A1 NSMicrophoneUsageDescription ios/Runner/Info.plist | tail -n1 | sed -E 's/.*>(.*)<.*/\1/')
if [ "$description" != "O microfone é necessário para gravar áudio enquanto você cria e compartilha seus projetos." ]; then
  echo "Descrição de uso do microfone inválida."
  exit 1
fi
