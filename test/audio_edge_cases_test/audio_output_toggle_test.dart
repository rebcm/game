import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Audio output toggles between speaker and headphone', (tester) async {
    await tester.pumpWidget(MyApp());

    final audioManager = AudioManager.instance;

    await tester.tap(find.byIcon(Icons.volume_up));
    await tester.pumpAndSettle();

    expect(audioManager.isOutputSpeaker, true);

    await tester.tap(find.byIcon(Icons.headphones));
    await tester.pumpAndSettle();

    expect(audioManager.isOutputSpeaker, false);
  });
}
