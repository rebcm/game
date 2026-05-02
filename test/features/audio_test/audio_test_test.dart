import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/audio_test/audio_test.dart';

void main() {
  testWidgets('Audio test widget test', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AudioTest()));
    expect(find.text('Teste de Áudio'), findsOneWidget);
  });
}
