#!/bin/bash

# Documentar as políticas de autoplay de áudio para Chrome, Safari e Firefox
echo "Documenting autoplay policies for Chrome, Safari, and Firefox..."

# Criar ou modificar o arquivo de documentação das políticas de autoplay
mkdir -p docs/autoplay_politicas
cat > docs/autoplay_politicas/autoplay_politicas.md << 'DOC_EOF'
# Políticas de Autoplay

Este documento descreve as políticas de autoplay de áudio para os principais navegadores: Chrome, Safari e Firefox.

## Chrome

O Chrome tem uma política de autoplay que permite o autoplay de mídia com som se o usuário tiver interagido com o site anteriormente.

### Critérios de Autoplay no Chrome

- O usuário interagiu com o domínio (clicou, tocou, etc.).
- No desktop, o limite de Média de Engajamento com Mídia (MEI) do usuário foi atingido.
- No mobile, o usuário adicionou o site à tela inicial.

## Safari

O Safari no iOS e iPadOS bloqueia o autoplay de mídia com som por padrão.

### Critérios de Autoplay no Safari

- O usuário interagiu com o site (clicou, tocou, etc.) antes do autoplay.

## Firefox

O Firefox permite o autoplay de mídia, mas com restrições baseadas nas preferências do usuário e no contexto da página.

### Critérios de Autoplay no Firefox

- A preferência do usuário em relação ao autoplay é respeitada.
- O autoplay é permitido se o site foi configurado para permitir autoplay na configuração do Firefox.

## Matriz de Critérios de Validação

| Navegador | Critérios de Autoplay |
|-----------|-----------------------|
| Chrome    | Interação prévia, MEI atingido (desktop), adicionado à tela inicial (mobile) |
| Safari    | Interação prévia |
| Firefox   | Preferências do usuário, configuração do site |

DOC_EOF

# Atualizar o pubspec.yaml para incluir o novo arquivo de documentação
sed -i '/docs\/swagger_endpoints.md/a \    - docs/autoplay_politicas/autoplay_politicas.md' pubspec.yaml

echo "Autoplay policies documentation created and pubspec.yaml updated."
