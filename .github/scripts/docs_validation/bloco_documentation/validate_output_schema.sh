#!/bin/bash

OUTPUT_FILE=$1

if ! command -v jq &> /dev/null; then
  echo "jq is not installed. Please install jq to continue."
  exit 1
fi

jq -e '.blocos | type == "array"' $OUTPUT_FILE > /dev/null
if [ $? -ne 0 ]; then
  echo "Validation failed: 'blocos' is not an array"
  exit 1
fi

for row in $(jq -r '.blocos[] | @base64' $OUTPUT_FILE); do
  _jq() {
    echo ${row} | base64 --decode | jq -r ${1}
  }

  id=$(_jq '.id')
  nome=$(_jq '.nome')
  descricao=$(_jq '.descricao')

  if [ -z "$id" ] || [ -z "$nome" ] || [ -z "$descricao" ]; then
    echo "Validation failed: Missing required field in bloco"
    exit 1
  fi
done

echo "Validation successful"
