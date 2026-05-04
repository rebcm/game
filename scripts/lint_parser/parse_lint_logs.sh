#!/bin/bash

# Script to parse 'flutter analyze' output and convert it to JSON

OUTPUT_FILE="lint_results.json"

flutter analyze --no-fatal-infos --no-fatal-warnings > analyze_output.txt

echo '[' > $OUTPUT_FILE

while IFS= read -r line; do
  if [[ $line =~ ^[[:space:]]*([[:alnum:]_/.]+):([0-9]+):([0-9]+):[[:space:]]*(error|warning):[[:space:]]*(.*) ]]; then
    FILE=${BASH_REMATCH[1]}
    LINE=${BASH_REMATCH[2]}
    COLUMN=${BASH_REMATCH[3]}
    SEVERITY=${BASH_REMATCH[4]}
    MESSAGE=${BASH_REMATCH[5]}

    echo "{
  \"file\": \"$FILE\",
  \"line\": $LINE,
  \"column\": $COLUMN,
  \"severity\": \"$SEVERITY\",
  \"message\": \"$MESSAGE\"
}," >> $OUTPUT_FILE
  fi
done < analyze_output.txt

# Remove the trailing comma
sed -i '$ s/,$//' $OUTPUT_FILE

echo ']' >> $OUTPUT_FILE

rm analyze_output.txt
