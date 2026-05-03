#!/bin/bash

# Run the app and measure memory usage before destroying the estado_jogo
mem_before=$(pmap -d $(pgrep flutter) | awk '/total/{print $2}')

# Destroy the estado_jogo
# NOTE: This step should be implemented based on the actual code and requirements
# For this example, we assume there's a function to destroy the game state
destroy_game_state

# Run the app and measure memory usage after destroying the estado_jogo
mem_after=$(pmap -d $(pgrep flutter) | awk '/total/{print $2}')

# Calculate the memory leak
mem_leak=$((mem_after - mem_before))

echo "Memory leak: $mem_leak bytes"
