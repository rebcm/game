# Mapeamento de Exceções de Atalhos Globais

## Introdução

Este documento visa documentar e testar a lista de teclas que NÃO devem ser interceptadas pelo jogo para evitar quebrar funcionalidades nativas do navegador.

## Critérios de Aceitação

1. **Lista de Teclas de Exceção**: Deve ser mantida uma lista de teclas que são consideradas exceções e não devem ser interceptadas pelo jogo.
2. **Funcionalidades Nativas**: As teclas de exceção devem permitir o funcionamento correto das funcionalidades nativas do navegador, como copiar (Ctrl+C), colar (Ctrl+V), desfazer (Ctrl+Z), etc.
3. **Testes Automatizados**: Devem ser implementados testes automatizados para verificar se as teclas de exceção estão funcionando corretamente.

## Lista de Teclas de Exceção

| Tecla | Descrição | Funcionalidade Nativa |
| --- | --- | --- |
| Ctrl+C | Copiar | Sim |
| Ctrl+V | Colar | Sim |
| Ctrl+Z | Desfazer | Sim |
| Ctrl+A | Selecionar Tudo | Sim |
| F5 | Atualizar Página | Sim |

## Implementação

A implementação deve ser feita de forma a não interceptar as teclas de exceção listadas acima. Isso pode ser alcançado através da adição de uma lógica de verificação antes de processar os eventos de teclado.

## Testes

Os testes automatizados devem ser implementados utilizando o framework de testes existente no projeto. Os testes devem cobrir os seguintes cenários:

* Verificar se as teclas de exceção não são interceptadas pelo jogo.
* Verificar se as funcionalidades nativas do navegador funcionam corretamente quando as teclas de exceção são pressionadas.

