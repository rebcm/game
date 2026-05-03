# Matriz de Resultados Esperados para Áudio

Este documento define a matriz de resultados esperados para o comportamento do áudio no jogo em diferentes cenários e plataformas.

## Cenários Testados

1. Modo Silencioso
2. Alternância de Hardware (fones de ouvido, alto-falantes)

## Plataformas

1. Android
2. iOS

## Matriz de Comportamento Esperado

| Cenário          | Plataforma | Comportamento Esperado                                      |
|------------------|------------|-------------------------------------------------------------|
| Modo Silencioso  | Android    | O áudio deve ser silenciado                                 |
| Modo Silencioso  | iOS        | O áudio deve ser silenciado                                 |
| Alternância HW   | Android    | O áudio deve continuar sem interrupção                     |
| Alternância HW   | iOS        | O áudio deve continuar sem interrupção                     |

## Critérios de Aceitação

1. O áudio deve ser silenciado quando o dispositivo está no modo silencioso.
2. A alternância de hardware não deve interromper a reprodução de áudio.

