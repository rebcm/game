import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  group('Resolution Matrix Tests', () {
    testWidgets('Test minimum resolution 320x480', (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 480));
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(find.text('Rebeca\'s Creative Building'), findsOneWidget);
    });

    testWidgets('Test minimum resolution 360x640', (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 640));
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(find.text('Rebeca\'s Creative Building'), findsOneWidget);
    });

    testWidgets('Test overflow on tips screen at 320x480', (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 480));
      await tester.pumpWidget(const MyApp());
      await tester.tap(find.text('Tips'));
      await tester.pumpAndSettle();
      expect(find.text('Tips'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Test overflow on tips screen at 360x640', (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 640));
      await tester.pumpWidget(const MyApp());
      await tester.tap(find.text('Tips'));
      await tester.pumpAndSettle();
      expect(find.text('Tips'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
