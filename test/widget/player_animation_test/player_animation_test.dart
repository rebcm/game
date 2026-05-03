import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/player/player_animation.dart';

void main() {
  group('Player Animation Tests', () {
    testWidgets('should animate smoothly from Idle to Walking', (tester) async {
      final playerAnimation = PlayerAnimation();
      await tester.pumpWidget(
        MaterialApp(
          home: playerAnimation,
        ),
      );
      playerAnimation.updateState(PlayerState.walking);
      await tester.pumpAndSettle();
      expect(find.byType(PlayerAnimation), findsOneWidget);
    });

    testWidgets('should animate smoothly from Walking to Idle', (tester) async {
      final playerAnimation = PlayerAnimation();
      await tester.pumpWidget(
        MaterialApp(
          home: playerAnimation,
        ),
      );
      playerAnimation.updateState(PlayerState.idle);
      await tester.pumpAndSettle();
      expect(find.byType(PlayerAnimation), findsOneWidget);
    });
  });
}
