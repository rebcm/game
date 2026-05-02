import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/validacao_limites_caracteres.dart';

void main() {
  testWidgets('Campo de texto deve aceitar input dentro do limite', (tester) async {
    final textController = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextField(
            controller: textController,
            maxLength: 100,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'a' * 100);
    expect(textController.text.length, 100);
  });

  testWidgets('Campo de texto deve truncar input acima do limite', (tester) async {
    final textController = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextField(
            controller: textController,
            maxLength: 100,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'a' * 101);
    expect(textController.text.length, 100);
  });
}
