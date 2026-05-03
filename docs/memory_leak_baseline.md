# Memory Leak Baseline Documentation

This document describes the baseline memory usage of the application.

## Baseline Value

The baseline value is stored in a separate file (`memory_leak_baseline.txt`) and represents the expected memory usage of the application.

## How to Update the Baseline

1. Run the application with the `leak_tracker` enabled.
2. Record the memory usage before and after the destruction of the `estado_jogo.dart` state.
3. Update the `memory_leak_baseline.txt` file with the new baseline value.

## Validation

The `validate_memory_leak_baseline.sh` script is used to validate the baseline value.
