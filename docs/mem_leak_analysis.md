# Memory Leak Analysis

## Introduction

This document describes the process of analyzing memory leaks in the game.

## Methodology

1. Start the flutter app in profile mode.
2. Measure the initial memory consumption.
3. Destroy `estado_jogo.dart`.
4. Wait for some time to allow garbage collection.
5. Measure the final memory consumption.
6. Calculate the memory leak by subtracting the initial memory consumption from the final memory consumption.

## Results

The memory leak analysis can be run using the script `.github/scripts/mem_leak_analysis/run_mem_leak_analysis.sh`.

## Baseline Results

To be filled with the baseline results of the memory leak analysis.
