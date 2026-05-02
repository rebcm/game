import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio_service.dart';

void main() {
  group('Critérios de Aceitação', () {
    test('Escala de Volume', () async {
      // Implementar teste para escala de volume
      expect(AudioService().volume, isBetween(0, 1));
    });

    test('Comportamento do Botão Mute', () async {
      // Implementar teste para comportamento do botão mute
      expect(AudioService().isMuted, isBoolean);
    });

    test('Persistência', () async {
      // Implementar teste para persistência
      expect(AudioService().loadVolume(), isNotNull);
    });
  });
}
