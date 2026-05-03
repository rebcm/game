import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/tips/widgets/tip_decider.dart';

void main() {
  testWidgets('TipDecider shows tooltip when shouldShowTooltip is true', (tester) async {
    final tooltip = Text('Tooltip');
    final widget = TipDecider(
      context: 'construction_screen',
      trigger: 'block_selection',
      tooltip: tooltip,
      modal: Text('Modal'),
    );

    await tester.pumpWidget(MaterialApp(home: widget));
    expect(find.text('Tooltip'), findsOneWidget);
  });

  testWidgets('TipDecider shows modal when shouldShowModal is true', (tester) async {
    final modal = Text('Modal');
    final widget = TipDecider(
      context: 'construction_screen',
      trigger: 'first_block_placement',
      tooltip: Text('Tooltip'),
      modal: modal,
    );

    await tester.pumpWidget(MaterialApp(home: widget));
    expect(find.text('Modal'), findsOneWidget);
  });

  testWidgets('TipDecider shows nothing when neither condition is met', (tester) async {
    final widget = TipDecider(
      context: 'invalid_context',
      trigger: 'invalid_trigger',
      tooltip: Text('Tooltip'),
      modal: Text('Modal'),
    );

    await tester.pumpWidget(MaterialApp(home: widget));
    expect(find.byType(Text), findsNothing);
  });
}
