#!/bin/bash

# Executar testes de integração do passdriver Flutter
flutter drive --target=integration_test/passdriver_flutter_integration_test.dart --profile

# Coletar métricas de performance
