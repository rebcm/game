import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/audio/gerenciador_audio.dart';

void main() {
  test('Tocar áudio', () async {
    final gerenciador = GerenciadorAudio();
    await gerenciador.tocarAudio('assets/audio/optimized/sfx/exemplo.mp3');
    // Adicionar delay para ouvir o áudio
    await Future.delayed(const Duration(seconds: 1));
  });
}
