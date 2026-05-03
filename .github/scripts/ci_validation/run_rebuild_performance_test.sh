#!/bin/bash

# Executa o teste de performance de rebuild para Undo/Redo
flutter drive --target=integration_test/rebuild_performance_test.dart --driver=test_driver/integration_test.dart --profile

