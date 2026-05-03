import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/player/player.dart';
import 'package:game/player/player_widget.dart';

void main() {
  group('Player Widget Tests', () {
    late Player player;

    setUp(() {
      player = Player();
    });

    testWidgets('Player widget updates with state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PlayerWidget(player: player),
        ),
      );

      player.idle();
      await tester.pump();
      expect(find.text('Idle'), findsOneWidget);

      player.walk();
      await tester.pump();
      expect(find.text('Walk'), findsOneWidget);

      player.run();
      await tester.pump();
      expect(find.text('Run'), findsOneWidget);
    });
  });
}
