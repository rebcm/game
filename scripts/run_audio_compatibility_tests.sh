#!/bin/bash

flutter drive --target=test_driver/integration_test.dart --driver=test_driver/integration_test_driver.dart --test-arguments='{"audio_output":"internal_speaker"}'
flutter drive --target=test_driver/integration_test.dart --driver=test_driver/integration_test_driver.dart --test-arguments='{"audio_output":"wired_headphones"}'
flutter drive --target=test_driver/integration_test.dart --driver=test_driver/integration_test_driver.dart --test-arguments='{"audio_output":"bluetooth"}'
flutter drive --target=test_driver/integration_test.dart --driver=test_driver/integration_test_driver.dart --test-arguments='{"audio_output":"hfp"}'
