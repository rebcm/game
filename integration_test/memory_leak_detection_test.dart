import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'dart:developer' as dev;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('detecção de vazamento de memória', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Realiza ações que potencialmente causam vazamento de memória
    await tester.tap(find.text('Criar Chunk'));
    await tester.pumpAndSettle();

    // Executa o garbage collector
    dev.HeapSnapshot().then((snapshot) {
      int timerCount = snapshot.objects.where((obj) => obj.klass == 'Timer').length;
      int chunkCount = snapshot.objects.where((obj) => obj.klass == 'Chunk').length;

      // Verifica se os critérios de aceitação são atendidos
      expect(timerCount, lessThanOrEqualTo(0));
      expect(chunkCount, lessThanOrEqualTo(10)); // valor pré-definido
    });
  });
}

