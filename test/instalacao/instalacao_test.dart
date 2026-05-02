import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;
import 'dart:io';

void main() {
  testWidgets('Validar instruções de instalação', (tester) async {
    // Simula um ambiente limpo
    await tester.runAsync(() async {
      // Executa os passos de instalação
      await Process.run('flutter', ['pub', 'get']);
      await Process.run('flutter', ['config', '--enable-web']);
      await Process.run('flutter', ['clean']);
      await Process.run('flutter', ['pub', 'get']);

      // Verifica se o app compila e roda
      await tester.pumpWidget(app.MyApp());
      expect(find.text('Rebeca'), findsOneWidget);
    });
  });
}
