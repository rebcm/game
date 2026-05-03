import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/accessibility/audio_controls.dart';

void main() {
  testWidgets('Audio controls are accessible', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AccessibleAudioControls(),
        ),
      ),
    );

    expect(find.bySemanticsLabel('Mute audio'), findsOneWidget);
    expect(find.bySemanticsLabel('Unmute audio'), findsOneWidget);
    expect(find.bySemanticsLabel('Volume slider'), findsOneWidget);
  });
}
