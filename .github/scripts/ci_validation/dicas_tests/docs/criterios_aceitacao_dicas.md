# Critérios de Aceitação para UI de Dicas

## Introdução

Este documento define os critérios de aceitação para a implementação da UI de dicas no jogo.

## Critérios de Aceitação

1. **Exibição de Dicas**:
   - A dica deve ser exibida quando o usuário passar o mouse sobre um bloco por mais de 500ms.
   - A dica deve conter o nome do bloco.

2. **Comportamento Esperado**:
   - A dica deve desaparecer quando o usuário mover o mouse para fora do bloco.
   - A dica não deve ser exibida se o usuário clicar em um bloco.

3. **Persistência**:
   - A dica deve permanecer visível enquanto o usuário mantém o mouse sobre o bloco.

## Métricas de Sucesso

1. **Taxa de Exibição**:
   - 100% das vezes que o usuário passar o mouse sobre um bloco por mais de 500ms, a dica deve ser exibida.

2. **Taxa de Desaparecimento**:
   - 100% das vezes que o usuário mover o mouse para fora do bloco, a dica deve desaparecer.

## Testes

Os critérios de aceitação devem ser testados utilizando testes de UI automatizados.
