# Matriz de Resultados Esperados para Áudio (iOS vs Android)

| Caso de Teste | Descrição | Comportamento Esperado iOS (AVAudioSession) | Comportamento Esperado Android (AudioManager) |
| --- | --- | --- | --- |
| Modo Silencioso | Aplicativo em modo silencioso | Áudio não deve ser reproduzido | Áudio não deve ser reproduzido |
| Troca de Output | Troca entre fones de ouvido e alto-falante | Áudio deve seguir a saída selecionada | Áudio deve seguir a saída selecionada |
| Interrupção por Outra Aplicação | Outra aplicação inicia reprodução de áudio | Áudio do jogo deve pausar | Áudio do jogo deve pausar |
| Retorno após Interrupção | Aplicação interrompida retorna ao foco | Áudio do jogo deve retomar | Áudio do jogo deve retomar |
| Volume Mínimo | Volume do dispositivo está no mínimo | Áudio não deve ser audível | Áudio não deve ser audível |
| Sem Dispositivo de Áudio | Sem fones de ouvido ou alto-falante | Áudio não deve ser reproduzido | Áudio não deve ser reproduzido |

