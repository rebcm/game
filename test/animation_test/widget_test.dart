import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/animation/player_movement.dart';

void main() {
  testWidgets('PlayerMovement widget test', (tester) async {
    final playerMovement = PlayerMovement();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedBuilder(
            animation: playerMovement,
            builder: (context, child) {
              return Text('Velocity: ${playerMovement.velocity}');
            },
          ),
        ),
      ),
    );
    playerMovement.updateDirection(1, 0);
    await tester.pump();
    playerMovement.updateDirection(-1, 0);
    await tester.pump();
    expect(find.text('Velocity: (0.0, 0.0)'), findsOneWidget);
  });
}
