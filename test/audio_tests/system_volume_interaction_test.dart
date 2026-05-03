import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('adjust system volume and verify audio response', (tester) async {
    await tester.pumpWidget(MyApp());

    final audioManager = AudioManager.instance;

    // Simulate system volume change
    await audioManager.onSystemVolumeChanged(0.5);

    // Verify audio volume is adjusted accordingly
    expect(audioManager.currentVolume, 0.5);
  });
}
