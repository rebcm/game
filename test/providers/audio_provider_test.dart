import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/providers/audio_provider.dart';

void main() {
  group('AudioProvider', () {
    late AudioProvider audioProvider;

    setUp(() {
      audioProvider = AudioProvider();
    });

    test('should not update global volume when volumeGuard is updating', () {
      audioProvider.updateIndividualVolume(0.5);
      audioProvider.updateGlobalVolume(0.7);
      // Add logic to verify global volume is not updated
    });

    test('should update global volume when volumeGuard is not updating', () {
      audioProvider.updateGlobalVolume(0.7);
      // Add logic to verify global volume is updated
    });
  });
}
