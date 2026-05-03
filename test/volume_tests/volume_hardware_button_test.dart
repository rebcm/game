import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Testa interação do controle de volume com botões físicos',
      (WidgetTester tester) async {
    await tester.pumpWidget(app.RebecaApp());

    // Simula pressionamento do botão de volume para cima
    await tester.binding.platformDispatcher.handlePlatformMessage(
      'flutter/volume',
      const StandardMethodCodec().encodeMethodCall(const MethodCall('volume.up')),
      (ByteData? data) {},
    );

    await tester.pumpAndSettle();

    // Verifica se o volume aumentou
    expect(find.text('Volume aumentou'), findsOneWidget);

    // Simula pressionamento do botão de volume para baixo
    await tester.binding.platformDispatcher.handlePlatformMessage(
      'flutter/volume',
      const StandardMethodCodec().encodeMethodCall(const MethodCall('volume.down')),
      (ByteData? data) {},
    );

    await tester.pumpAndSettle();

    // Verifica se o volume diminuiu
    expect(find.text('Volume diminuiu'), findsOneWidget);
  });
}
