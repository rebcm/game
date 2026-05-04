import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:audioplayers/audioplayers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Memory Leak Test for Audio Players', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final AudioPlayer audioPlayer = AudioPlayer();

    for (int i = 0; i < 10; i++) {
      await audioPlayer.play('path_to_test_audio.mp3', isLocal: true);
      await Future.delayed(Duration(seconds: 1));
    }

    await audioPlayer.dispose();

    // Verify memory usage or check for memory leaks using Flutter DevTools
    // This step might require manual verification using Flutter DevTools
  });
}
