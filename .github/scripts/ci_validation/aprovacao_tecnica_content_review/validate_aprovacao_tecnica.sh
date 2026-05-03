#!/bin/bash

# Validate if the content has been approved by the Game Designer or Technical Lead
CONTENT_APPROVAL_STATUS=$(cat docs/dicas_construcao/conteudo_dicas.md | grep -c "APPROVED_BY_GAME_DESIGNER_OR_TECHNICAL_LEAD")

if [ $CONTENT_APPROVAL_STATUS -eq 0 ]; then
  echo "Content approval validation failed. The content has not been approved by the Game Designer or Technical Lead."
  exit 1
else
  echo "Content approval validation successful. The content has been approved by the Game Designer or Technical Lead."
  exit 0
fi
