import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/audio_system/lib/audio_system.dart';
void main() {
  test('deve reproduzir áudio', () async {
    final audioSystem = AudioSystem();
    await audioSystem.playAudio('https://example.com/audio.mp3');
    // Verificar se o áudio foi reproduzido corretamente
  });
}
