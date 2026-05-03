import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/audio_service.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Audio stress test', (tester) async {
    await tester.pumpWidget(MyApp());

    final audioService = AudioService();

    for (var i = 0; i < 100; i++) {
      await audioService.playAudio('test_audio.mp3');
      await tester.pumpAndSettle(Duration(seconds: 1));
      await audioService.stopAudio();
      await tester.pumpAndSettle(Duration(seconds: 1));
    }
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Stress Test',
      home: Scaffold(
        body: Center(
          child: Text('Audio Stress Test'),
        ),
      ),
    );
  }
}
