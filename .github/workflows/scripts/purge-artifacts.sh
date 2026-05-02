#!/bin/bash

# Delete old artifacts
for artifact in $(gh api /repos/rebcm/game/actions/artifacts --paginate --jq '.artifacts[] | select(.expired == false) | .id'); do
  echo "Deleting artifact $artifact"
  gh api /repos/rebcm/game/actions/artifacts/$artifact -X DELETE
done
