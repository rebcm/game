#!/bin/bash

# Script to parse 'flutter analyze' output and convert it to JSON format

# Check if output file is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <output_file.json>"
    exit 1
fi

OUTPUT_FILE=$1

# Run flutter analyze and capture output
flutter analyze > analyze_output.txt 2>&1

# Parse the output and convert to JSON
echo '[' > $OUTPUT_FILE
while IFS= read -r line; do
    if [[ $line =~ ^([[:alnum:]\/\_\-\.]+):([0-9]+):([0-9]+):\ (error|warning):\ (.*) ]]; then
        FILE_PATH=${BASH_REMATCH[1]}
        LINE=${BASH_REMATCH[2]}
        COLUMN=${BASH_REMATCH[3]}
        SEVERITY=${BASH_REMATCH[4]}
        MESSAGE=${BASH_REMATCH[5]}
        echo "{\"file_path\":\"$FILE_PATH\",\"line\":$LINE,\"column\":$COLUMN,\"severity\":\"$SEVERITY\",\"message\":\"$MESSAGE\"}," >> $OUTPUT_FILE
    fi
done < analyze_output.txt
# Remove trailing comma if it exists
if [ $(wc -l < $OUTPUT_FILE) -gt 1 ]; then
    sed -i '$ s/,$//' $OUTPUT_FILE
fi
echo ']' >> $OUTPUT_FILE

# Clean up
rm analyze_output.txt
