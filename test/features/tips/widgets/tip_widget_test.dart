import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/tips/widgets/tip_widget.dart';

void main() {
  testWidgets('TipWidget shows tooltip when appropriate', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TipWidget(context: 'construction_screen', trigger: 'block_selection'),
      ),
    );
    expect(find.byType(Tooltip), findsOneWidget);
  });

  testWidgets('TipWidget shows modal when appropriate', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TipWidget(context: 'construction_screen', trigger: 'unknown_trigger'),
      ),
    );
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('TipWidget shows nothing when no tip is appropriate', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TipWidget(context: 'unknown_context', trigger: 'unknown_trigger'),
      ),
    );
    expect(find.byType(SizedBox), findsOneWidget);
  });
}
