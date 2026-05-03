import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game/widgets/game_widget.dart';

void main() {
  testWidgets('Game widget test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: GameWidget(),
      ),
    );

    expect(find.byType(GameWidget), findsOneWidget);
  });
}
