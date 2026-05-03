#!/bin/bash

# Este script executa o teste de vazamento de memória

flutter drive --target=test/integration_tests/memory_leak_test.dart --driver=test/integration_tests/memory_leak_test_driver.dart --profile --trace-startup --cache-maintenance --purge-persistent-cache --no-headless

