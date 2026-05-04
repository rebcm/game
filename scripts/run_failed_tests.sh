#!/bin/bash

flutter drive --target=test_driver/integration_test.dart --driver=test_driver/integration_test_driver.dart --test-name="teste_integracao_audio"
flutter drive --target=test_driver/integration_test.dart --driver=test_driver/integration_test_driver.dart --test-name="teste_renderizacao_3d"
flutter drive --target=test_driver/integration_test.dart --driver=test_driver/integration_test_driver.dart --test-name="teste_carregamento_chunks"

