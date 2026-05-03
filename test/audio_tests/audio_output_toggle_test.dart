import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('toggle audio output between speaker and headphone', (tester) async {
    await tester.pumpWidget(MyApp());

    final audioManager = AudioManager.instance;

    // Initial output is speaker
    expect(audioManager.currentOutput, AudioOutput.speaker);

    // Toggle to headphone
    await audioManager.toggleOutput();
    expect(audioManager.currentOutput, AudioOutput.headphone);

    // Toggle back to speaker
    await audioManager.toggleOutput();
    expect(audioManager.currentOutput, AudioOutput.speaker);
  });
}
