#!/bin/bash

description=$(grep -A1 NSCameraUsageDescription ios/Runner/Info.plist | tail -n1 | sed -E 's/.*>(.*)<.*/\1/')
if [ "$description" != "A câmera é usada para tirar fotos dos seus blocos criativos e compartilhá-los com a comunidade." ]; then
  echo "Descrição de uso da câmera inválida."
  exit 1
fi
