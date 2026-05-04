#!/bin/bash

# Script para executar testes que falharam anteriormente

# Executar testes de integração
flutter drive --target=test_driver/integration_test.dart --driver=test_driver/integration_test_driver.dart

# Executar edge cases
