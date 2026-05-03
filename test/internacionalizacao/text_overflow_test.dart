import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Testa overflow de texto em idiomas longos', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.pumpAndSettle();

    // Verifica se há overflow em widgets de texto
    final textWidgets = tester.widgetList(find.byType(Text));
    for (var textWidget in textWidgets) {
      final text = textWidget as Text;
      final textSpan = TextSpan(text: text.data);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        locale: const Locale('de', 'DE'), // Testa com locale alemão
      )..layout(maxWidth: textWidget.style?.fontSize ?? 100);
      expect(textPainter.didExceedMaxLines, false);
    }
  });
}
