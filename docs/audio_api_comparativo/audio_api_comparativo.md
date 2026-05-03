# Comparativo de Comportamento de Áudio

Este documento apresenta uma matriz comparativa do comportamento esperado para Android e iOS nos cenários de modo silencioso e alternância de hardware.

## Matriz de Resultados Esperados

| Cenário | Ação | Resultado Esperado (Android) | Resultado Esperado (iOS) |
| --- | --- | --- | --- |
| Modo Silencioso | Reproduzir Áudio | Áudio não é reproduzido | Áudio não é reproduzido |
| Alternância de Hardware | Trocar de Dispositivo de Saída | Áudio continua a ser reproduzido no novo dispositivo | Áudio continua a ser reproduzido no novo dispositivo |
| Modo Silencioso com Alternância de Hardware | Reproduzir Áudio e Trocar de Dispositivo de Saída | Áudio não é reproduzido inicialmente e permanece sem reprodução após troca | Áudio não é reproduzido inicialmente e permanece sem reprodução após troca |

## Considerações

- A tabela acima resume o comportamento esperado para os cenários testados.
- É importante garantir que o aplicativo se comporte conforme o esperado em ambos os sistemas operacionais.

