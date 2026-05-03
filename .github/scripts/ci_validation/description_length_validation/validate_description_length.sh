#!/bin/bash

DESCRIPTION=$(grep 'description:' pubspec.yaml | cut -d ':' -f 2- | xargs)
LENGTH=${#DESCRIPTION}

if [ $LENGTH -gt 80 ]; then
  echo "Descrição muito longa. Limite: 80 caracteres. Comprimento atual: $LENGTH"
  exit 1
else
  echo "Descrição dentro do limite."
  exit 0
fi
