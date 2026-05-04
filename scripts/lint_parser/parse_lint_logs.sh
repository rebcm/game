#!/bin/bash

# Script to parse flutter analyze logs into JSON format

OUTPUT_FILE="lint_results.json"

flutter analyze --no-fatal-infos --no-fatal-warnings > analyze_output.txt

echo '[' > $OUTPUT_FILE

while IFS= read -r line; do
  if [[ $line =~ ^([[:alnum:]\/\_\-\.]+):([0-9]+):([0-9]+):\ (error|warning):\ (.*) ]]; then
    FILE_PATH=${BASH_REMATCH[1]}
    LINE=${BASH_REMATCH[2]}
    COLUMN=${BASH_REMATCH[3]}
    SEVERITY=${BASH_REMATCH[4]}
    MESSAGE=${BASH_REMATCH[5]}
    
    echo "  {" >> $OUTPUT_FILE
    echo "    \"file\": \"$FILE_PATH\"," >> $OUTPUT_FILE
    echo "    \"line\": $LINE," >> $OUTPUT_FILE
    echo "    \"column\": $COLUMN," >> $OUTPUT_FILE
    echo "    \"severity\": \"$SEVERITY\"," >> $OUTPUT_FILE
    echo "    \"message\": \"$MESSAGE\"" >> $OUTPUT_FILE
    echo "  }," >> $OUTPUT_FILE
  fi
done < analyze_output.txt

sed -i '$ s/,$//' $OUTPUT_FILE
echo ']' >> $OUTPUT_FILE

rm analyze_output.txt
