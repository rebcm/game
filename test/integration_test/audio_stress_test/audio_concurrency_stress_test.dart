import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testa reprodução de múltiplos sons simultâneos', (tester) async {
    await tester.pumpWidget(MyApp());
    final audioManager = AudioManager.instance;

    for (int i = 0; i < 10; i++) {
      audioManager.playSound('sfx/sound.mp3');
    }

    await tester.pumpAndSettle(Duration(seconds: 1));

    expect(audioManager.isPlaying, isTrue);
  });

  testWidgets('Testa comportamento com arquivos de áudio ausentes', (tester) async {
    await tester.pumpWidget(MyApp());
    final audioManager = AudioManager.instance;

    audioManager.playSound('sfx/non_existent_sound.mp3');

    await tester.pumpAndSettle(Duration(seconds: 1));

    expect(audioManager.isPlaying, isFalse);
  });

  testWidgets('Testa comportamento com arquivos de áudio corrompidos', (tester) async {
    await tester.pumpWidget(MyApp());
    final audioManager = AudioManager.instance;

    audioManager.playSound('sfx/corrupted_sound.mp3');

    await tester.pumpAndSettle(Duration(seconds: 1));

    expect(audioManager.isPlaying, isFalse);
  });
}
