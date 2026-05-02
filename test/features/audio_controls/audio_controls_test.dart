import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/features/audio_controls/audio_controls.dart';

void main() {
  testWidgets('AudioControls has play/pause button and volume slider', (tester) async {
    await tester.pumpWidget(MaterialApp(home: AudioControls()));
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    expect(find.byType(Slider), findsOneWidget);
  });

  testWidgets('Play/Pause button toggles playback', (tester) async {
    await tester.pumpWidget(MaterialApp(home: AudioControls()));
    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pump();
    expect(find.byIcon(Icons.pause), findsOneWidget);
  });

  testWidgets('Volume slider changes volume', (tester) async {
    await tester.pumpWidget(MaterialApp(home: AudioControls()));
    final slider = find.byType(Slider);
    await tester.drag(slider, Offset(10, 0));
    await tester.pump();
    // Verificar mudança de volume
  });
}
