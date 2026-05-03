import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/ui/widgets/tips/tip_modal.dart';

void main() {
  testWidgets('TipModal displays tip and closes on button press', (tester) async {
    await tester.pumpWidget(MaterialApp(home: TipModal(tip: 'Test tip')));
    expect(find.text('Dica'), findsOneWidget);
    expect(find.text('Test tip'), findsOneWidget);
    await tester.tap(find.text('Entendi'));
    await tester.pumpAndSettle();
    expect(find.byType(TipModal), findsNothing);
  });
}
