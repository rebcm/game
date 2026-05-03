#!/bin/bash

# Executa testes de sincronização de volume
flutter drive --target=test_driver/integration_test.dart --driver=test_driver/volume_sync_test.dart
