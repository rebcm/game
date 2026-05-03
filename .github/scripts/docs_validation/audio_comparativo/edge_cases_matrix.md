# Matriz de Resultados Esperados para Áudio (iOS vs Android)

| Caso de Teste | Descrição | Comportamento Esperado iOS (AVAudioSession) | Comportamento Esperado Android (AudioManager) |
| --- | --- | --- | --- |
| Modo Silencioso | Aplicativo em modo silencioso | O áudio deve ser silenciado | O áudio deve ser silenciado |
| Troca de Output | Troca entre alto-falantes e fones de ouvido | O áudio deve seguir a saída selecionada | O áudio deve seguir a saída selecionada |
| Interrupção por Outra Aplicação | Outra aplicação assume o controle de áudio | O áudio deve pausar | O áudio deve pausar |
| Retorno ao Aplicativo | Aplicativo reassume o controle de áudio | O áudio deve retomar | O áudio deve retomar |

### Versões Mínimas Suportadas
Para mais detalhes sobre as versões mínimas suportadas pelo Flutter SDK, consulte [minimas_versoes_suportadas.md](../flutter_sdk_versoes/minimas_versoes_suportadas.md).
