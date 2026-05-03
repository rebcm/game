# Matriz de Resultados Esperados para Áudio

A tabela a seguir apresenta o comportamento esperado do sistema de áudio do jogo em diferentes cenários e plataformas.

| Cenário | Plataforma | Comportamento Esperado |
| --- | --- | --- |
| Modo Silencioso | Android | O áudio do jogo deve ser silenciado |
| Modo Silencioso | iOS | O áudio do jogo deve ser silenciado |
| Alternância de Hardware | Android | O áudio do jogo deve ser pausado e retomado corretamente |
| Alternância de Hardware | iOS | O áudio do jogo deve ser pausado e retomado corretamente |

## Critérios de Aceitação

1. O áudio do jogo deve ser silenciado quando o dispositivo estiver no modo silencioso.
2. O áudio do jogo deve ser pausado e retomado corretamente quando houver alternância de hardware.

## Referências

- [Critérios de Aceitação para Áudio](../.github/scripts/ci_validation/audio_edge_cases_test/docs/criterios_aceitacao_audio.md)
