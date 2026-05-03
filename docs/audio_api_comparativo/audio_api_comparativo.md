# Comparativo de Comportamento de Áudio

Este documento apresenta uma matriz comparativa do comportamento esperado para o sistema de áudio nos dispositivos Android e iOS, considerando cenários de modo silencioso e alternância de hardware.

## Matriz de Resultados Esperados

| Cenário | Android | iOS |
| --- | --- | --- |
| Reprodução de áudio com dispositivo não silenciado | Áudio reproduzido | Áudio reproduzido |
| Reprodução de áudio com dispositivo silenciado | Áudio não reproduzido | Áudio não reproduzido |
| Alternância de hardware (fones de ouvido para alto-falante) | Áudio continua reproduzindo no novo dispositivo de saída | Áudio continua reproduzindo no novo dispositivo de saída |
| Interrupção por chamada telefônica ou outra aplicação | Áudio pausado ou interrompido | Áudio pausado ou interrompido |
| Retorno após interrupção | Áudio retoma reprodução | Áudio retoma reprodução |

## Considerações Adicionais

- **Modo Silencioso:** Em ambos os sistemas, o modo silencioso deve impedir a reprodução de áudio.
- **Alternância de Hardware:** A aplicação deve ser capaz de lidar com mudanças no dispositivo de saída de áudio sem interrupções significativas.
- **Interrupções:** A aplicação deve pausar ou interromper a reprodução de áudio durante chamadas telefônicas ou quando outra aplicação assume o controle do áudio.

