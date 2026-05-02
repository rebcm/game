#!/bin/bash

states=("initial" "loading" "game" "pause" "settings")
transitions=(
  "initial:loading"
  "loading:game"
  "game:pause"
  "pause:game"
  "pause:settings"
  "settings:pause"
  "game:settings"
  "settings:game"
)

echo "State Transition Matrix:"
echo "  | ${states[@]}"
for state in "${states[@]}"; do
  echo -n "$state | "
  for next_state in "${states[@]}"; do
    valid_transition=false
    for transition in "${transitions[@]}"; do
      if [[ "$transition" == "$state:$next_state" ]]; then
        valid_transition=true
        break
      fi
    done
    if $valid_transition; then
      echo -n "X "
    else
      echo -n ". "
    fi
  done
  echo
done
