#!/bin/bash

flutter drive --target=test/stress_test/game_screen_stress_test.dart --driver=test_driver/integration_test.dart
flutter drive --driver=test/integration/stress_test/timer_stress_test.dart --target=lib/main.dart
flutter drive --driver=test/integration/stress_test/timer_stress_test_with_memory_check.dart --target=lib/main.dart
