import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/audio_manager.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AudioManager lifecycle tests', () {
    test('AudioManager should release all resources when disposed', () async {
      await expectLater(
        AudioManager(),
        isNotLeaking,
      );
    });

    test('AudioManager should not leak memory on multiple initializations', () async {
      for (var i = 0; i < 10; i++) {
        final audioManager = AudioManager();
        await audioManager.dispose();
      }
      await expectLater(
        AudioManager(),
        isNotLeaking,
      );
    });
  });
}
