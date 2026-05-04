import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/audio_compression_service.dart';

void main() {
  test('compressAudio', () async {
    final service = AudioCompressionService();
    await service.compressAudio('input_path', 'output_path');
    // Verificar se o arquivo de saída foi criado
  });
}
