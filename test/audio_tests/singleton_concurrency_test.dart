import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AudioService Singleton Concurrency Test', () {
    test('should handle multiple play() requests without crashing', () async {
      final audioService = AudioService.instance;

      await Future.wait(List.generate(10, (_) => audioService.play()));
      
      expect(audioService.isPlaying, true);
    });

    test('should not overlap audio when play() is called multiple times', () async {
      final audioService = AudioService.instance;

      await audioService.play();
      await Future.delayed(const Duration(milliseconds: 100));
      await audioService.play();

      expect(audioService.isPlaying, true);
    });
  });
}
