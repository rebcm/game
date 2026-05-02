import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/self_healing/storage_limit_test.dart';

void main() {
  group('Storage Limit Test', () {
    testWidgets('should resume execution after manual resolution', (tester) async {
      await tester.pumpWidget(const StorageLimitTestWidget());
      expect(find.text('Erro de Limite de Armazenamento'), findsOneWidget);
      await tester.tap(find.text('Resolver Manualmente'));
      await tester.pumpAndSettle();
      expect(find.text('Execução retomada com sucesso'), findsOneWidget);
    });
  });
}
