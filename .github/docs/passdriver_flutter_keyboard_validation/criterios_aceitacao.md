# Critérios de Aceitação para Validação de Teclas Globais

## Introdução

Este documento define os critérios de aceitação para a validação de teclas globais no jogo Construção Criativa da Rebeca. O objetivo é garantir que as teclas globais não interceptem funcionalidades nativas do navegador.

## Critérios de Aceitação

1. **Lista de Teclas Globais**: Deve ser documentada a lista de teclas que são consideradas globais e não devem ser interceptadas pelo jogo.
2. **Testes de Validação**: Devem ser implementados testes para validar que as teclas globais não são interceptadas pelo jogo.
3. **Funcionalidades Nativas**: As funcionalidades nativas do navegador, como Ctrl+T, Ctrl+N, Ctrl+Shift+I, devem funcionar corretamente enquanto o jogo está em execução.

## Lista de Teclas Globais

A lista de teclas globais inclui, mas não se limita a:

- Ctrl+T (Nova aba)
- Ctrl+N (Nova janela)
- Ctrl+Shift+I (Ferramentas de desenvolvedor)
- F5 (Atualizar página)
- F12 (Ferramentas de desenvolvedor)

## Implementação

A implementação deve ser feita de forma a não interceptar as teclas globais listadas acima. Isso pode ser alcançado através da verificação da tecla pressionada e permitindo que o evento seja propagado para o navegador se for uma tecla global.

## Testes

Os testes devem ser implementados para garantir que as teclas globais não são interceptadas. Isso pode ser feito utilizando testes de integração que simulam a pressão das teclas globais e verificam se as funcionalidades nativas do navegador são executadas corretamente.

