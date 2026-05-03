# Critérios de Aceitação para Testes de Áudio (Edge Cases)

## Introdução

Este documento define os critérios de aceitação para os testes de áudio relacionados a edge cases no jogo.

## Critérios

1. O jogo deve pausar a reprodução de áudio quando o dispositivo está no modo silencioso.
2. O jogo deve retomar a reprodução de áudio quando o dispositivo sai do modo silencioso.
3. O jogo deve pausar a reprodução de áudio quando o dispositivo perde conexão.
4. O jogo deve retomar a reprodução de áudio quando o dispositivo recupera a conexão.
5. O jogo deve pausar a reprodução de áudio quando interrompido por uma chamada telefônica.
6. O jogo deve retomar a reprodução de áudio após a chamada telefônica ser finalizada.
7. O jogo deve lidar corretamente com diferentes permissões de hardware para reprodução de áudio.

## Aprovação

Os testes de áudio (edge cases) serão considerados aprovados quando todos os critérios acima forem atendidos.
