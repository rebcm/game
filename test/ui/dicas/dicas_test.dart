import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/ui/dicas/dicas.dart';

void main() {
  testWidgets('Dica é exibida após 500ms', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dicas()));
    final gestureDetector = find.byType(GestureDetector);
    await tester.hover(gestureDetector);
    await tester.pump(Duration(milliseconds: 500));
    expect(find.text('Nome do Bloco'), findsOneWidget);
  });

  testWidgets('Dica desaparece quando mouse sai do bloco', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dicas()));
    final gestureDetector = find.byType(GestureDetector);
    await tester.hover(gestureDetector);
    await tester.pump(Duration(milliseconds: 500));
    await tester.hover(find.byType(Container), position: Offset(100, 100));
    await tester.pump();
    expect(find.text('Nome do Bloco'), findsNothing);
  });
}
