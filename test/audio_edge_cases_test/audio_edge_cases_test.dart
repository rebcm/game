import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Audio Edge Cases Test', () {
    testWidgets('alteração de volume com áudio em execução', (tester) async {
      // Implement test logic here
      await AudioService.instance.playAudio('test_audio.mp3');
      await Future.delayed(Duration(seconds: 1));
      await AudioService.instance.setVolume(0.5);
      expect(AudioService.instance.volume, 0.5);
    });

    testWidgets('mute rápido sucessivo', (tester) async {
      // Implement test logic here
      await AudioService.instance.playAudio('test_audio.mp3');
      await Future.delayed(Duration(seconds: 1));
      await AudioService.instance.mute();
      await AudioService.instance.mute();
      expect(AudioService.instance.isMuted, true);
    });

    testWidgets('inicialização do app com volume zero', (tester) async {
      // Implement test logic here
      await AudioService.instance.setVolume(0.0);
      await AudioService.instance.init();
      expect(AudioService.instance.volume, 0.0);
    });
  });
}
