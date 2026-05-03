#!/bin/bash
dart ./.github/scripts/docs_validation/dicas/extract_dicas_strings.dart > temp_dicas_strings.txt
diff -q temp_dicas_strings.txt ./docs/dicas_strings.csv || (echo "Dicas strings are not up-to-date. Please run ./run_extract_dicas_strings.sh to update." && exit 1)
rm temp_dicas_strings.txt
