# Critérios de Aceitação para Comparativo de Áudio

Este documento define os critérios de aceitação para o comparativo de comportamento do áudio entre Android e iOS nos cenários de modo silencioso e alternância de hardware.

## Cenários de Teste

1. **Modo Silencioso**
   - Verificar se o áudio é silenciado corretamente em ambos os sistemas (Android e iOS) quando o dispositivo está no modo silencioso.
   
2. **Alternância de Hardware**
   - Testar a troca de saída de áudio (por exemplo, entre fones de ouvido e alto-falantes) e verificar se o áudio continua a funcionar corretamente em ambos os sistemas.

## Matriz de Resultados Esperados

| Cenário          | Android                          | iOS                              |
|------------------|----------------------------------|----------------------------------|
| Modo Silencioso  | Áudio silenciado                 | Áudio silenciado                 |
| Alternância de Hardware | Áudio continua após troca       | Áudio continua após troca       |

## Critérios de Aceitação

1. O áudio deve ser silenciado em ambos os sistemas quando o dispositivo está no modo silencioso.
2. A alternância de hardware não deve interromper a reprodução de áudio em nenhum dos sistemas.

## Aprovação

O comparativo de áudio será considerado aprovado se atender a todos os critérios de aceitação definidos nesta matriz.
