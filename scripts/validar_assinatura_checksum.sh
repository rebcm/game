#!/bin/bash

# Baixar artefato
echo "Baixando artefato..."
# Implementar lógica para baixar o artefato

# Validar assinatura
echo "Validando assinatura..."
gpg --verify rebcm-game-binary.sig rebcm-game-binary

# Calcular e validar checksum
echo "Calculando e validando checksum..."
EXPECTED_CHECKSUM="expected_checksum_value"
ACTUAL_CHECKSUM=$(sha256sum rebcm-game-binary | cut -d' ' -f1)
if [ "$ACTUAL_CHECKSUM" == "$EXPECTED_CHECKSUM" ]; then
  echo "Checksum válido."
else
  echo "Checksum inválido."
  exit 1
fi
