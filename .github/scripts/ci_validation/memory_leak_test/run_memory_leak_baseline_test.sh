#!/bin/bash

# Este script executa o teste de baseline de memória para o estado_jogo.dart

# Executar o teste de memória antes da destruição do estado_jogo.dart
flutter run --profile --test-memory-leak-before-destroy > memory_leak_before_destroy.log

# Executar o teste de memória depois da destruição do estado_jogo.dart
flutter run --profile --test-memory-leak-after-destroy > memory_leak_after_destroy.log

# Extrair os resultados dos logs
before_destroy=$(grep 'Memory usage:' memory_leak_before_destroy.log | awk '{print $3}')
after_destroy=$(grep 'Memory usage:' memory_leak_after_destroy.log | awk '{print $3}')

# Calcular a diferença de memória
leak=$(($after_destroy - $before_destroy))

# Salvar os resultados em um arquivo
echo "Memória antes da destruição: $before_destroy bytes" > memory_leak_results.log
echo "Memória depois da destruição: $after_destroy bytes" >> memory_leak_results.log
echo "Diferença de memória: $leak bytes" >> memory_leak_results.log
