import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/player_movement_widget.dart';

void main() {
  testWidgets('Player movement widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PlayerMovementWidget(),
      ),
    );

    // Perform widget tests here
  });
}
