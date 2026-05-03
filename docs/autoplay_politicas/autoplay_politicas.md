# Políticas de Autoplay de Áudio

Este documento descreve as políticas de autoplay de áudio para os principais navegadores: Chrome, Safari e Firefox.

## Chrome

O Chrome tem uma política de autoplay restritiva. O autoplay é permitido se:
- O usuário interagiu com o site (por exemplo, clicou ou pressionou uma tecla).
- O site foi adicionado à tela inicial (PWA).
- O usuário permitiu o autoplay anteriormente.

## Safari

O Safari também tem restrições de autoplay. O autoplay é permitido se:
- O usuário interagiu com o site.
- O site foi configurado para permitir autoplay através de uma política de mídia.

## Firefox

O Firefox permite autoplay, mas com algumas restrições. O autoplay é permitido se:
- O site foi configurado para permitir autoplay.
- O usuário não bloqueou o autoplay.

## Critérios de Validação

Para garantir que o jogo atenda às políticas de autoplay, devemos:
1. Implementar interação do usuário antes de iniciar o áudio.
2. Verificar se o site foi adicionado à tela inicial (para Chrome).
3. Configurar as políticas de mídia adequadamente (para Safari).

Essas diretrizes devem ser seguidas para evitar problemas de autoplay nos principais navegadores.
