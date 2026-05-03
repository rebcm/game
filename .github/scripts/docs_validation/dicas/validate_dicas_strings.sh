#!/bin/bash
diff=$(diff lib/docs/dicas/dicas_strings.txt lib/docs/dicas/dicas_strings_golden.txt)
if [ -n "$diff" ]; then
  echo "Dicas strings validation failed:"
  echo "$diff"
  exit 1
fi
