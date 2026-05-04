#!/bin/bash

# Script to parse flutter analyze logs into JSON format

OUTPUT_FILE="lint_results.json"

flutter analyze --no-fatal-infos --no-fatal-warnings > analyze_logs.txt

echo "[" > $OUTPUT_FILE

while IFS= read -r line; do
  if [[ $line =~ ^([a-zA-Z0-9_/.-]+):([0-9]+):([0-9]+):\ (error|warning):\ (.*) ]]; then
    FILE_PATH=${BASH_REMATCH[1]}
    LINE_NUMBER=${BASH_REMATCH[2]}
    COLUMN_NUMBER=${BASH_REMATCH[3]}
    SEVERITY=${BASH_REMATCH[4]}
    MESSAGE=${BASH_REMATCH[5]}
    
    echo "  {" >> $OUTPUT_FILE
    echo "    \"file_path\": \"$FILE_PATH\"," >> $OUTPUT_FILE
    echo "    \"line_number\": $LINE_NUMBER," >> $OUTPUT_FILE
    echo "    \"column_number\": $COLUMN_NUMBER," >> $OUTPUT_FILE
    echo "    \"severity\": \"$SEVERITY\"," >> $OUTPUT_FILE
    echo "    \"message\": \"$MESSAGE\"" >> $OUTPUT_FILE
    echo "  }," >> $OUTPUT_FILE
  fi
done < analyze_logs.txt

sed -i '$ s/,$//' $OUTPUT_FILE
echo "]" >> $OUTPUT_FILE

rm analyze_logs.txt
