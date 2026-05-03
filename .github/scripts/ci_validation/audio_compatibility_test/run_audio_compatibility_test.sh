#!/bin/bash

# Testes de compatibilidade de áudio

# Testes de alternância de saída de áudio em dispositivos Android e iOS
flutter drive --target=test_driver/audio_compatibility_test.dart --driver=test_driver/audio_compatibility_test_driver.dart

# Testes de modo silencioso em dispositivos Android e iOS
flutter drive --target=test_driver/silent_mode_test.dart --driver=test_driver/silent_mode_test_driver.dart
