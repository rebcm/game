# Mapeamento de Exceções de Atalhos Globais

## Introdução

Este documento visa mapear as teclas que não devem ser interceptadas pelo jogo para evitar quebrar funcionalidades nativas do navegador.

## Lista de Exceções

A seguir, está a lista de teclas que devem ser ignoradas pelo jogo:

*   `F5` - Atualizar página
*   `Ctrl + R` - Atualizar página (no Windows/Linux)
*   `Cmd + R` - Atualizar página (no Mac)
*   `Ctrl + Shift + I` - Abrir DevTools (no Windows/Linux)
*   `Cmd + Opt + I` - Abrir DevTools (no Mac)
*   `F12` - Abrir DevTools
*   `Ctrl + S` - Salvar página (no Windows/Linux)
*   `Cmd + S` - Salvar página (no Mac)
*   `Ctrl + P` - Imprimir página (no Windows/Linux)
*   `Cmd + P` - Imprimir página (no Mac)

## Testes

Para garantir que essas teclas não sejam interceptadas, devem ser realizados testes com as seguintes ações:

1.  Abrir o jogo em diferentes navegadores.
2.  Pressionar cada uma das teclas listadas acima e verificar se a funcionalidade nativa do navegador é executada corretamente.

## Critérios de Aceitação

*   Todas as teclas listadas acima devem ser ignoradas pelo jogo.
*   As funcionalidades nativas do navegador devem funcionar corretamente quando essas teclas forem pressionadas.

