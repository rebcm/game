#!/bin/bash

# Testar fluxo de integração da UI
flutter test integration_test/flujo_integracion_test.dart

# Validar documentação do fluxo
diff -q docs/flujo_integracion/flujo_integracion.md docs/flujo_integracion/flujo_integracion_expected.md
