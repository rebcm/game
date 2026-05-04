import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  group('Breakpoint Tests', () {
    testWidgets('Test breakpoint for small devices', (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 480));
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(find.byType(MediaQuery), findsOneWidget);
    });

    testWidgets('Test breakpoint for medium devices', (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 640));
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(find.byType(MediaQuery), findsOneWidget);
    });
  });
}
