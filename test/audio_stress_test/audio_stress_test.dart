import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Audio stress test', (tester) async {
    await tester.pumpWidget(MyApp());

    final audioManager = AudioManager.instance;

    for (int i = 0; i < 100; i++) {
      audioManager.playSound('sfx/sound_effect.mp3');
      await Future.delayed(Duration(milliseconds: 50));
    }

    await tester.pumpAndSettle();

    expect(audioManager.isPlaying, false);
  });
}
