# Mapeamento de Exceções de Atalhos Globais

## Introdução

Este documento visa documentar e testar a lista de teclas que NÃO devem ser interceptadas pelo jogo para evitar quebrar funcionalidades nativas do browser.

## Lista de Teclas de Exceção

As seguintes teclas ou combinações de teclas devem ser ignoradas pelo jogo para garantir a funcionalidade padrão do browser:

- `Ctrl + N` (Nova janela/aba)
- `Ctrl + T` (Nova aba)
- `Ctrl + Shift + T` (Reabrir aba fechada)
- `Ctrl + W` ou `Ctrl + F4` (Fechar aba)
- `Alt + F4` (Fechar janela)
- `F5` ou `Ctrl + R` (Atualizar página)
- `Ctrl + S` (Salvar página)
- `Ctrl + P` (Imprimir página)
- `Ctrl + Shift + I` ou `F12` (Abrir DevTools)
- `Ctrl + U` (Ver código-fonte da página)

## Critérios de Aceitação

1. O jogo deve ignorar as teclas listadas acima, permitindo que o browser execute suas funcionalidades padrão.
2. O jogo deve continuar funcionando normalmente para todas as outras teclas não listadas acima.
3. A lista de teclas de exceção deve ser testada em diferentes browsers e plataformas (Windows, macOS, Linux).

## Testes

Os testes devem ser realizados para garantir que o jogo não intercepta as teclas de exceção e que o browser execute as ações esperadas. Os testes devem cobrir diferentes cenários, incluindo:

- Abertura de novas abas/janelas
- Fechamento de abas/janelas
- Atualização da página
- Salvamento da página
- Impressão da página
- Abertura das DevTools
- Visualização do código-fonte da página

## Implementação

A implementação deve envolver a modificação do código de tratamento de teclas do jogo para ignorar as teclas de exceção. Isso pode ser feito adicionando uma lista de teclas ignoradas e verificando essa lista antes de processar qualquer tecla pressionada.

